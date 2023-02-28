vid1 = videoinput('winvideo', 2, 'MJPG_1920x1080');     % ����� ������ �������� ����� ����� (c���� ��������),������,��� ����������
vid2 = videoinput('winvideo', 3, 'MJPG_1920x1080');     %������

vid1.TriggerRepeat = Inf;
vid2.TriggerRepeat = Inf;

% src1 = getselectedsource(vid1);
% src2 = getselectedsource(vid2);

preview(vid1);      % ��������� � �����
preview(vid2);

 global LOOP_RUNNING;
LOOP_RUNNING = true;

while (LOOP_RUNNING)
%����� �� 960 � 540
imgR = getsnapshot(vid2); % 3 ���� ������ ������� ���� ����� ������ ������
imgL = getsnapshot(vid1); 

% imshow(imgR);
% hold on;
% line( [ 0, 1920 ], [540, 540 ], 'Color', 'red', 'LineStyle','-');
% line( [960, 960], [0, 1080] , 'Color', 'red', 'LineStyle','-');
% 
% 
% imshow(imgL);
% hold on;
% line( [ 0, 1920 ], [540, 540 ], 'Color', 'red', 'LineStyle','-');
% line( [960, 960], [0, 1080] , 'Color', 'red', 'LineStyle','-');
subplot(1,2,1), imshow(imgL)
hold on;
line( [ 0, 1920 ], [540, 540 ], 'Color', 'red', 'LineStyle','-');
line( [960, 960], [0, 1080] , 'Color', 'red', 'LineStyle','-');
subplot(1,2,2), imshow(imgR)
hold on;
line( [ 0, 1920 ], [540, 540 ], 'Color', 'red', 'LineStyle','-');
line( [960, 960], [0, 1080] , 'Color', 'red', 'LineStyle','-');

pause(0.5);
end


stop (vid1);        % ����� � ���� ��������� � ����� �����
stop (vid2);

