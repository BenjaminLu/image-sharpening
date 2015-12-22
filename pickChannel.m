function [result ] = pickChannel( img, channel )
    [height, width, color] = size(img);
    result = zeros(height, width, 'double');
    result(:, :) = img(:, :, channel);
end

