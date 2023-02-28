leftCam = imaq.VideoDevice('winvideo', 1, 'MJPG_640x360');     % второе значение номер порта (cтоит уточнить),третье,это разрешение
rightCam = imaq.VideoDevice('winvideo', 3, 'MJPG_640x360');
leftCam.ReturnedDataType = 'uint8';
% leftCam.DeviceProperties.FocusMode = 'manual';    
% leftCam.DeviceProperties.WhiteBalanceMode = 'manual';

rightCam.ReturnedDataType = 'uint8';
% rightCam.DeviceProperties.FocusMode = 'manual';
% rightCam.DeviceProperties.WhiteBalanceMode = 'manual';

if ~exist ('stereoParams', 'var')
    load stereOB4
end

ax = axes;
maxDepth = 5;

while true
    imageLeft = step(leftCam);
    imageRight = step(rightCam);
    
    [J1, J2] = rectifyStereoImages(imageLeft, imageRight, stereoParams);
    
    disp  = disparity (rgb2gray(J1),rgb2gray(J2), 'DisparityRange', [0, 64] );
   
    pointCloud = reconstructScene(disp, stereoParams) ./1000;
    
    z = pointCloud (:, :, 3);
    z (z < 0) = NaN;
    z (z > maxDepth) = NaN;
    pointCloud (:, :, 3) = z;
    
    if ~ishandle(ax)
        break;
    else
        pcshow(pointCloud, J1, 'VerticalAxis', 'Y', ...
            'VerticalAxisDir', 'Down', 'Parent', ax);
        
        xlabel('X (m)');
        ylabel('Y (m)');
        zlabel('Z (m)');
        
        xlim (ax, [-.8, .8]);
        ylim (ax, [-.8, .8]);
        zlim(ax, [0, maxDepth]);
        daspect(ax,'manual');
        pbaspect (ax, 'manual');
        drawnow;
      
    end
end

release (leftCam);
release (rightCam); 