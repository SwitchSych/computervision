vid1 = videoinput('winvideo', 2, 'MJPG_640x360');     % второе значение номер порта (cтоит уточнить),третье,это разрешение
vid2 = videoinput('winvideo', 3, 'MJPG_640x360');

preview(vid1);      % предпоказ с камер
preview(vid2);      % ѕ–ќ¬≈–№  ј јя Ћ≈¬јя,  ј јя ѕ–ј¬јя

pause(5);           % ѕауза дл€ того чтобы € успел отойти 
imgL = getsnapshot (vid1);
imgR = getsnapshot (vid2);

stop (vid1);        % чтобы € смог выключить в конце видео
stop (vid2);

    tR_1=['E:\ƒиплом\'];       % проверь правое левое
    tR_3 =['.jpg'];
    
    tL_1=['E:\ƒиплом\'];
    tL_3=['.jpg'];
    
        tR_2 = 'imgRight35';
        tL_2 = 'imgLeft35';
        
    tR = strcat(tR_1,tR_2,tR_3);
    tL = strcat(tL_1,tL_2,tL_3);
    
    imwrite (imgR,tR ,'jpg')
    imwrite (imgL, tL, 'jpg')
