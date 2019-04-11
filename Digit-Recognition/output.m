% Reads from i.e. './Data/1-1.png' and feeds it into the decision_tree
% function.
% The output is appended to output.csv in the form for 1-1.png to 1-3.png
%   1 | output                      (1-1 img)
%   1 | output                      (1-2 img)
%   1 | output                      (1-3 img)
%   2 | output                      (2-1 img)
path = './Data/';
arr = [];
for digit = 0:9
    for img = 1:3
        imgpath = strcat(path,string(digit),'-',string(img),'.png');
        img = imread(imgpath);
        img = ~(im2bw(img));
        features = [extractFeatures(img) digit];
        label = decision_tree(features);
        arr = [arr; digit label];
    end
end

csvwrite('./output.csv', arr);