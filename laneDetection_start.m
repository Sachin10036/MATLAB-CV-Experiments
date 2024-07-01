function laneDetection_start
    img = imread('highway.jpg');
    figure; imshow(img); title('Original Image');
    laneMask = createLaneMask(img);
    skeletonizedMask = bwmorph(laneMask, 'thin', Inf);

    [H, theta, rho] = hough(skeletonizedMask);
    P = houghpeaks(H, 5, 'Threshold', 0.3 * max(H(:)), 'NHoodSize', [31 31]);
    lines = houghlines(skeletonizedMask, theta, rho, P, 'FillGap', 80, 'MinLength', 150);

    posArray = getVizPosArray(lines);

    annotatedImg = insertShape(img, 'line', posArray, 'LineWidth', 2, 'Color', 'red');

    figure; imshow(annotatedImg); title('Annotated Image');
end

function laneMask = createLaneMask(img)
    
    grayImg = rgb2gray(img);
    blurredImg = imgaussfilt(grayImg, 3);
    edgeImg = edge(blurredImg, 'canny');

    [rows, cols, ~] = size(img);
    ROI = [cols/2, 0; cols, rows; 0, rows];

    laneMask = poly2mask(ROI(:,1), ROI(:,2), rows, cols);
    laneMask = laneMask & edgeImg;
end

function posArray = getVizPosArray(lines)
    posArray = zeros(length(lines)*2, 2);

    for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];
        posArray((k-1)*2+1:k*2, :) = xy;
    end
end

