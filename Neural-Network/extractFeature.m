function features = extractFeature(img)
% Convert binary image to a normalizedvector of features
% to input into neural network
features = zeros(64,1); % Each min, max pair is f(i), f(i + 1)

[rows cols] = size(img);
xCenter = round(cols / 2);
yCenter = round(rows / 2);

% Slightly center image using centroids
% So we don't offset white pixels by too much
props = regionprops(img, 'Centroid');
rowShift = ((rows/2) - props.Centroid(2)) / 10;
colShift = ((cols/2) - props.Centroid(1)) / 10;
img = circshift(img, [round(rowShift) round(colShift)]);

% Extract boundary region
% Idea is to isolate pixels in each interval by using a circular mask
% with specific angles and then take min, max of each interval.
strel = [0 1 0; 1 1 1; 0 1 0];
img = img & (~imerode(img, strel));

i = 1; % indexing for feature vector

interval_step = pi/16; % Each quadrant divided into 8 slices
radius = max(size(img));
% [0 - pi/16, pi/16 - pi / 8, ...]
for theta = 0: interval_step : 2*pi - interval_step
    subtheta = theta : .01 : theta + interval_step - .01;
    x = radius * cos(subtheta) + xCenter;
    y = radius * sin(subtheta) + yCenter;
    x = [xCenter, x, xCenter];
    y = [yCenter, y, yCenter];
    mask = poly2mask(x,y,size(img, 1), size(img, 2));
    
    slice = mask & img;
    imshow(slice);
    [r, c] = find(slice); % Coordinates of 1s
    
    if(size(r, 1) == 0) % No white pixels found - use 0 and 1 as placeholders
                        % to avoid NaN values
        features(i) = 0;
        features(i + 1) = 1;
    else
        dist = sqrt((r - yCenter).^2 + (c - xCenter).^2);
        features(i) = min(dist);
        features(i + 1) = max(dist);
    end
    i = i + 2;
end
% Normalize
features = features / max(features);
end