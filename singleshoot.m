vid1 = videoinput('winvideo', 2, 'MJPG_640x360');     % ������ �������� ����� ����� (c���� ��������),������,��� ����������
vid2 = videoinput('winvideo', 3, 'MJPG_640x360');

preview(vid1);      % ��������� � �����
preview(vid2);      % ������� ����� �����, ����� ������

pause(5);           % ����� ��� ���� ����� � ����� ������ 
imgL = getsnapshot (vid1);
imgR = getsnapshot (vid2);

stop (vid1);        % ����� � ���� ��������� � ����� �����
stop (vid2);

    tR_1=['E:\������\'];       % ������� ������ �����
    tR_3 =['.jpg'];
    
    tL_1=['E:\������\'];
    tL_3=['.jpg'];
    
        tR_2 = 'imgRight35';
        tL_2 = 'imgLeft35';
        
    tR = strcat(tR_1,tR_2,tR_3);
    tL = strcat(tL_1,tL_2,tL_3);
    
    imwrite (imgR,tR ,'jpg')
    imwrite (imgL, tL, 'jpg')
