
%������, ��� ���� �������, ��� ���������� ��������� � Stereo Calibrator,
%����� ��� ���������
tic
showExtrinsics(stereoParams);       %���������� ������������ ������ � ������������ � ���������� ���� ��� ����������

%�������� ���� ����������� 
% imageFileLeft = 'E:\������\imgLeft1.jpg';
% imageFileRight = 'E:\������\imgRight1.jpg';

imageFileRight = 'E:\������\imgLeft23.jpg';
imageFileLeft = 'E:\������\imgRight23.jpg';

%��������� ����������� � � �������
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
title ('Unrectified Stereo Image');     % ���������� ���� ������������ ����������� �� ��� y

[imgLeftRect, imgRightRect] = ...
    rectifyStereoImages(readerLeft, readerRight, stereoParams,'OutputView','valid');    % ������ ������������ �� ��� Y

figure;
 imshow(stereoAnaglyph(imgLeftRect, imgRightRect));
 title('Rectified Image Frames');

 % ����������� �������� ����� ������ imgaussfilt ��� ��� ��� 3d
 % imgaussfilt3 - �������� ����������� ����� ���������� �� ������
 
 
imgLeftGray  = rgb2gray(imgLeftRect);       % ������� RGB � ����� ����, ��� ��� disparity �������� � ���
imgRightGray = rgb2gray(imgRightRect);

 %� ������������ ������������������ ����� ���� ��������������� ����� ����������� � ����� ���� ��������.
 %��� ������� ������� � ����� ����������� ��������� ���������� �� ���������������� ������� � ������ �����������.
 %��� ���������� ���������� ��������������, � ��� ��������������� ���������� �� ������ �� ��������������� ����� ����.
disparityMap = disparity(imgLeftGray, imgRightGray);  
figure;
imshow(disparityMap, [0 64]); %[0, 64] �������� ������
% ������� ������� ����� �������������� ��� ����� ������� ���������
title('Disparity Map');
figure;
colormap jet
colorbar


% ������ � �������( ����� 3d �����, �� ������� ���������� ������������� ��
% ����� ������������ �� ������� ������� �� ����� ���������� ����������
% ������� 

points3D = reconstructScene(disparityMap, stereoParams);
points3D = points3D ./ 1000;    %����� ��� ����� �� ������, ����� ����� ���������� � ������
ptCloud = pointCloud(points3D, 'Color', imgLeftRect);

% figure;
% Z = points3D(:, :, 3);
% mask = repmat(Z > 1200 & Z < 1600, [1, 1, 3]);
% imgLeftGray(~mask) = 0;
% imshow(imgLeftGray, 'InitialMagnification', 50);

player3D = pcplayer([-1.5, 1.5], [-1.5, 1.5], [0, 7], 'VerticalAxis', 'y', ...
    'VerticalAxisDir', 'down');
%������������ ��� X Y Z ������� �� ��������� � ��


view(player3D, ptCloud);
toc
% https://www.mathworks.com/help/vision/ug/depth-estimation-from-stereo-video.html
% ��������� ��� ��� ������ ����� �� ����������� 




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


