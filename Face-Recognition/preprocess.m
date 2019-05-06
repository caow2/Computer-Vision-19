function img = preprocess(img)
% Takes in grayscale image and preprocesses it
% Returns a rescaled 10000 element vector for each image
img = imresize(img, [100 100]); % to 100 x 100
img = double(img(:)); % to vector
img = img / norm(img); % normalize 
end