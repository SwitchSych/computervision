
imageFileRight = 'E:\Диплом\imgLeft33.jpg';
readerLeft = imread(imageFileLeft);
sigma = 2;
readerLeftNew = imgaussfilt3(readerLeft, sigma);
figure;
%subplot(2,1,1)

subplot(1,2,1), imshow(readerLeft)
title('Without Filter')
subplot(1,2,2), imshow(readerLeftNew)
title('With Gaussian Filter')


figure;
readerLeftNew = medfilt2(readerLeft);
subplot(1,2,1), imshow(readerLeft)
title('Without Filter')
subplot(1,2,2), imshow(readerLeftNew)
title('With Median Filter')