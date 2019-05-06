function [X, XLabel, Y, YLabel] = load_images(people)
% Load images of people & convert each image into a unit vector w/ 10000 elements
% Divide the resulting images into training and testing sets
% Training set should contain a few images of each person and a label for nearest neighbors
% Testing set should contain remaining images of each person
path = './images/';
num_img = 10; % # of images per person
num_training = 5; % # training images per person

X = zeros(num_training * size(people, 2), 100 * 100);
Y = zeros((num_img - num_training) * size(people,2), 100 * 100); % rest goes into testing
XLabel = zeros(size(X, 1), 1);
YLabel = zeros(size(Y, 1), 1);

y_idx = 1; % index for y
x_idx = 1;
for i = 1 : size(people, 2)
    for j = 1 : num_img
        % Read image and convert to grayscale
        img_path = strcat(path, num2str(people(i)), '/', num2str(j), '.tif');
        img = imread(img_path);

        img = preprocess(img);

        if j <= num_training 
            X(x_idx, :) = img;
            XLabel(x_idx, :) = people(i);
            x_idx = x_idx + 1;
        else
            Y(y_idx, :) = img;
            YLabel(y_idx, :) = people(i);
            y_idx = y_idx + 1;
        end
    end
end
% Convert to the form [x1 x2 x3 ...]
X = X.';
Y = Y.';
XLabel = XLabel.';
YLabel = YLabel.';
end