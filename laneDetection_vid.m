% Script to run lane detection on a video file

% Call the detectLanesInVideo function with the video filename
detectLanesInVideo('project_video.mp4');

function detectLanesInVideo(videoFilename)
    % Create video file reader object
    vidReader = VideoReader(videoFilename);

    % Create video file writer object to save annotated video
    outputVideo = VideoWriter('annotated_video.avi');
    open(outputVideo);

    % Process each frame of the video
    frameCount = 0;
    while hasFrame(vidReader)
        frameCount = frameCount + 1;
        disp(['Processing frame: ', num2str(frameCount)]);
        
        % Read the frame
        frame = readFrame(vidReader);

        % Detect lanes in the frame
        annotatedFrame = detectLanes(frame);

        % Write annotated frame to the output video
        writeVideo(outputVideo, annotatedFrame);
    end

    % Close video file writer
    close(outputVideo);
    disp('Video processing completed.');
end


function annotatedFrame = detectLanes(frame)
    % Threshold the image to create a binary mask of the lines
    laneMask = createLaneMask(frame);

    % Skeletonize lines to make thin lines
    skeletonizedMask = bwmorph(laneMask, 'thin', Inf);

    % Perform a Hough transform on the binary mask
    [H, theta, rho] = hough(skeletonizedMask);

    % Identify peaks in the Hough matrix
    P = houghpeaks(H, 5, 'Threshold', 0.3 * max(H(:)), 'NHoodSize', [31 31]);

    % Extract lines from the binary mask using Hough transform
    lines = houghlines(skeletonizedMask, theta, rho, P, 'FillGap', 80, 'MinLength', 150);

    % Get points for visualization
    posArray = getVizPosArray(lines);

    % Visualize the lines on the original frame
    annotatedFrame = insertShape(frame, 'line', posArray, 'LineWidth', 2, 'Color', 'red');
end

function laneMask = createLaneMask(img)
    % Convert the image to grayscale
    grayImg = rgb2gray(img);

    % Apply Gaussian blur to the grayscale image
    blurredImg = imgaussfilt(grayImg, 3);

    % Perform edge detection using Canny edge detector
    edgeImg = edge(blurredImg, 'canny');

    % Define region of interest (ROI)
    [rows, cols, ~] = size(img);
    ROI = [cols/2, 0; cols, rows; 0, rows];

    % Create binary mask for ROI
    laneMask = poly2mask(ROI(:,1), ROI(:,2), rows, cols);

    % Apply the mask to the edge image
    laneMask = laneMask & edgeImg;
end

function posArray = getVizPosArray(lines)
    % Initialize position array
    posArray = zeros(length(lines)*2, 2);

    % Extract points for visualization
    for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];
        posArray((k-1)*2+1:k*2, :) = xy;
    end
end
