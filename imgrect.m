% img = imread ('E:\Диплом\imgLeft.jpg');
% imshow (img);
% %imtool (img);
%  hold on
% rectangle ('Position', [187, 189, 250, 173], 'EdgeColor','r');
I1 = imread('E:\Диплом\imgLeft.jpg');
I2 = imread('E:\Диплом\imgRight.jpg');
[J1, J2] = rectifyStereoImages(I1, I2, stereoParams);

figure; 
imshow(cat(3, J1(:,:,1), J2(:,:,2:3)), 'InitialMagnification', 50);

disparityMap = disparity(rgb2gray(J1), rgb2gray(J2));
figure; imshow(disparityMap, [0, 64], 'InitialMagnification', 50);
pointCloud = reconstructScene(disparityMap, stereoParams);

Z = pointCloud(:, :, 3);
mask = repmat(Z > 1400 & Z < 2000, [1, 1, 3]);
J1(~mask) = 0;
imshow(J1, 'InitialMagnification', 50);