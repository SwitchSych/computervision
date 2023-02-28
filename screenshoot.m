vid1 = videoinput('winvideo', 2, 'MJPG_640x360');     %Левая  второе значение номер порта,третье,это разрешение
vid2 = videoinput('winvideo', 3, 'MJPG_640x360');     %Правая

preview(vid1);      % предпоказ с камер
preview(vid2);      % ПРОВЕРЬ КАКАЯ ЛЕВАЯ, КАКАЯ ПРАВАЯ

pause(5);           % Пауза для того чтобы я успел отойти 
imgL = getsnapshot (vid1);
imgR = getsnapshot (vid2);
stop (vid1);        % чтобы я смог выключить в конце видео
stop (vid2);

n=2;                % время паузы между снимками 
    tL_1=['E:\Диплом\Left1\'];       % проверь правое левое
    tL_3 =['.jpg'];
    
    tR_1=['E:\Диплом\Right1\'];
    tR_3=['.jpg'];
for i = 1:50
    imgL = getsnapshot (vid1);
    imgR = getsnapshot(vid2);
    
    tR_2 = int2str(i);
    tL_2 = int2str(i);
    tL = strcat(tL_1,tL_2,tL_3);
    tR = strcat(tR_1,tR_2,tR_3);
    imwrite (imgR,tR ,'jpg')
    imwrite (imgL, tL, 'jpg')
    pause(n);
    
end