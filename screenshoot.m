vid1 = videoinput('winvideo', 2, 'MJPG_640x360');     %�����  ������ �������� ����� �����,������,��� ����������
vid2 = videoinput('winvideo', 3, 'MJPG_640x360');     %������

preview(vid1);      % ��������� � �����
preview(vid2);      % ������� ����� �����, ����� ������

pause(5);           % ����� ��� ���� ����� � ����� ������ 
imgL = getsnapshot (vid1);
imgR = getsnapshot (vid2);
stop (vid1);        % ����� � ���� ��������� � ����� �����
stop (vid2);

n=2;                % ����� ����� ����� �������� 
    tL_1=['E:\������\Left1\'];       % ������� ������ �����
    tL_3 =['.jpg'];
    
    tR_1=['E:\������\Right1\'];
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