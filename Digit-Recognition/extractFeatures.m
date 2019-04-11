function features = extractFeatures(img)
% Structuring Elements
% Use a large SE to close, and small SE to dilate
dilate_se = [0 1 1 0; 1 1 1 1; 1 1 1 1; 0 1 1 0];
close_se = strel('disk', 23);

imshow(img);

% Center image
[rows cols] = size(img);
props = regionprops(img, 'Centroid', 'Orientation');   % (x, y)
rowShift = round((rows/2) - props.Centroid(2));
colShift = round((cols/2) - props.Centroid(1));
img = circshift(img, [rowShift colShift]);

% Extract connected components
closed = imclose(img, close_se) & ~img;
[labeled, numComponents] = bwlabel(closed);
imshow(closed);

% Extract Bays & Lakes
dilated = imdilate(closed, dilate_se);
imshow(dilated);
bay_img = dilated & ~img & ~closed;
[b_labeled, numBays] = bwlabel(bay_img);
lakes = numComponents - numBays;
imshow(bay_img);

% Get relative direction of bays using the centroids from lids
% Get average amongst lid centroid and take slope using leftmost lid centroid
% and average lid centroid
% Direction = 1 is positive direction, -1 is negative direction, 0 for no
% direction (i.e. no bays)
direction = 0;
if(numBays > 0)
    props = regionprops(bay_img, 'Centroid');
    avg_centroid = [0,0];
    for i = 1:numBays
        ctrd = props(i).Centroid;
        avg_centroid(1) = avg_centroid(1) + ctrd(1);
        avg_centroid(2) = avg_centroid(2) + ctrd(2);
    end
    avg_centroid = avg_centroid / numBays;
    left_centroid = props(1).Centroid;
    slope = (avg_centroid(2) - left_centroid(2))/(avg_centroid(1) - left_centroid(1));

    % Because of how the coordinate system is set up, a positive slope
    % indicates negative direction, and vice versa
    if(slope > 0)
        direction = -1;
    elseif (slope < 0)
        direction = 1;
    end
end

features = [lakes numBays direction];
end