clear variables
close all
clc

%read image
img = imread('pic/Lenna.jpg');
paddedImg = padarray(double(img),[1 1], 'replicate');

redChannel = pickChannel(paddedImg, 1);
greenChannel = pickChannel(paddedImg, 2);
blueChannel = pickChannel(paddedImg, 3);
[height, width, color] = size(paddedImg);
resultImg = zeros(height, width, 'double');

figure, imshow(uint8(redChannel), [min(uint8(redChannel(:))) max(uint8(redChannel(:)))]);
figure, imshow(uint8(greenChannel), [min(uint8(greenChannel(:))) max(uint8(greenChannel(:)))]);
figure, imshow(uint8(blueChannel), [min(uint8(blueChannel(:))) max(uint8(blueChannel(:)))]);

red = mixin(redChannel);
green = mixin(greenChannel);
blue = mixin(blueChannel);

resultImg(:, :, 1) = red(:, :);
resultImg(:, :, 2) = green(:, :);
resultImg(:, :, 3) = blue(:, :);

figure, imshow(uint8(paddedImg));
figure, imshow(uint8(resultImg));
imwrite(uint8(resultImg), 'pic\hw2.jpg');

