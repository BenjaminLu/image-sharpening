function [ resultImg ] = mixin( channel )
    %get size
    [height, width, color] = size(channel);

    sobelImg = zeros(height, width, 'double');
    avgFilteredImg = zeros(height, width, 'double');
    laplacianImg = zeros(height, width, 'double');
    resultImg = zeros(height, width, 'double');

    %Sobel filter
    for x = 2 : width - 1
        for y = 2 : height - 1
            Gx = (channel(y - 1, x + 1) + 2 * channel(y, x + 1) + channel(y + 1, x + 1)) - ...
                (channel(y - 1, x - 1) + 2 * channel(y, x - 1) + channel(y + 1, x - 1));
            Gy = (channel(y + 1, x - 1) + 2 * channel(y + 1, x) + channel(y + 1, x + 1)) - ...
                (channel(y - 1, x - 1) + 2 * channel(y - 1, x) + channel(y - 1, x + 1));
            value = abs(Gx) + abs(Gy);
            sobelImg(y, x) = value;
        end
    end

    %average filter
    for x = 2 : width - 1
        for y = 2 : height - 1
            topLeft = sobelImg(y - 1, x - 1);
            topCenter = sobelImg(y - 1, x);
            topRight = sobelImg(y - 1, x + 1);

            centerLeft = sobelImg(y, x - 1);
            center = sobelImg(y, x);
            centerRight = sobelImg(y, x + 1);

            bottomLeft = sobelImg(y + 1, x - 1);
            bottomCenter = sobelImg(y + 1, x);
            bottomRight = sobelImg(y + 1, x + 1);

            avg = double(topLeft + topCenter + topRight + ...
                centerLeft + center + centerRight + ...
                bottomLeft + bottomCenter + bottomRight) / 9;

            avgFilteredImg(y, x) = avg;
        end
    end

    %normalize
    maxElement = max(avgFilteredImg(:));
    avgFilteredImg(:) = avgFilteredImg(:) / maxElement;

    %Laplacian filter
    for x = 2 : width - 1
        for y = 2 : height - 1
            value = 4 * channel(y, x) - channel(y - 1, x) - channel(y, x - 1) - channel(y, x + 1) - channel(y + 1, x);
            laplacianImg(y, x) = value;
        end
    end

    %mixin
    for x = 1 : width
        for y = 1 : height
            resultImg(y, x) = avgFilteredImg(y, x) .* laplacianImg(y, x);
            resultImg(y, x) = resultImg(y, x) + channel(y, x);
        end
    end
end

