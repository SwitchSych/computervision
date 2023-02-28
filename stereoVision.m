
%первое, что надо сделать, это подгрузить параметры с Stereo Calibrator,
%важны оба параметра
tic
showExtrinsics(stereoParams);       %показывает расположение камеры в пространстве и предыдущие слои при калибровке

%загрузка двух изображений 
% imageFileLeft = 'E:\Диплом\imgLeft1.jpg';
% imageFileRight = 'E:\Диплом\imgRight1.jpg';

imageFileRight = 'E:\Диплом\imgLeft23.jpg';
imageFileLeft = 'E:\Диплом\imgRight23.jpg';

%считываем изображение в б таблицу
readerLeft = imread(imageFileLeft);
readerRight = imread(imageFileRight);

% readerLeft = imgaussfilt(readerLeft, 'FilterSize',[3 3]);
% readerRight = imgaussfilt(readerRight, 'FilterSize',[3 3]);

readerLeft = medfilt3(readerLeft);
readerRight = medfilt3(readerRight);
sigma = 1;
readerLeft = imgaussfilt3(readerLeft, sigma);
readerRight = imgaussfilt3(readerRight, sigma);



% readerLeft = imboxfilt3(readerLeft);
% readerRight = imboxfilt3(readerRight);


figure;
%subplot(2,1,1)

% subplot(1,2,1), imshow(readerLeft)
% title('Without Filter')
% subplot(1,2,2), imshow(readerLeftNew)
% title('With Filter')


figure;
subplot(2,1,1)
imshowpair (readerLeft, readerRight);
title ('Unrectified Stereo Image');     % показывает пару невыравняных изображений по оси y

[imgLeftRect, imgRightRect] = ...
    rectifyStereoImages(readerLeft, readerRight, stereoParams,'OutputView','valid');    % делает выравнивание по оси Y

figure;
 imshow(stereoAnaglyph(imgLeftRect, imgRightRect));
 title('Rectified Image Frames');

 % попробовать добавить Гаусс фильтр imgaussfilt или уже для 3d
 % imgaussfilt3 - зашумить изображение чтобы избавиться от бликов
 
 
imgLeftGray  = rgb2gray(imgLeftRect);       % перевод RGB в серые тона, так как disparity работает с ним
imgRightGray = rgb2gray(imgRightRect);

 %В выпрямленных стереоизображениях любая пара соответствующих точек расположена в одном ряду пикселей.
 %Для каждого пикселя в левом изображении вычислите расстояние до соответствующего пикселя в правом изображении.
 %Это расстояние называется диспаратностью, и оно пропорционально расстоянию от камеры до соответствующей точки мира.
disparityMap = disparity(imgLeftGray, imgRightGray);  
figure;
imshow(disparityMap, [0 64]); %[0, 64] диапазон цветов
% Выводим цветную карту несоответствия для более точного понимания
title('Disparity Map');
figure;
colormap jet
colorbar


% работа с точками( вывод 3d сцены, на которой изображено реконструкцию из
% карты несходимости по которой понятно на каком расстоянии находиться
% обьекты 

points3D = reconstructScene(disparityMap, stereoParams);
points3D = points3D ./ 1000;    %делят все точки на тысячу, чтобы иметь расстояние в метрах
ptCloud = pointCloud(points3D, 'Color', imgLeftRect);

% figure;
% Z = points3D(:, :, 3);
% mask = repmat(Z > 1200 & Z < 1600, [1, 1, 3]);
% imgLeftGray(~mask) = 0;
% imshow(imgLeftGray, 'InitialMagnification', 50);

player3D = pcplayer([-1.5, 1.5], [-1.5, 1.5], [0, 7], 'VerticalAxis', 'y', ...
    'VerticalAxisDir', 'down');
%переделывает оси X Y Z изменяя их растояние и тд


view(player3D, ptCloud);
toc
% https://www.mathworks.com/help/vision/ug/depth-estimation-from-stereo-video.html
% написаный код для поиска людей на изображении 




% ptCloud = reconstructScene(disparityMap, stereoParams);
% pcshow (ptCloud)
% xlabel ('x')
% ylabel ('y')
% zlabel ('z')
% 
% figure;
% 
% th = [-500 500;-200 200;0 1000];
% ptcloud = thresholdPC(ptCloud,th);
% pcshow (ptCloud)
% xlabel ('x')
% ylabel ('y')
% zlabel ('z')
% %threshacceptbnd


