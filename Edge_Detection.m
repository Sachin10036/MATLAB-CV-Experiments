I = imread('Coins.jpg');
if size(I, 3) == 3
    I = rgb2gray(I);
end
I_smoothed = imgaussfilt(I, 1);

edge_image = edge(I_smoothed, 'Canny');

figure;
subplot(1, 2, 1);
imshow(I);
title('Original Image');

subplot(1, 2, 2);
imshow(edge_image);
title('Edge-Detected Image');