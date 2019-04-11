% Wen Cao - Computer Vision HW 2
img = imread('deer.png');
A = ~(im2bw(img));
imwrite(A,'deer-bw.png');

skeleton_points = zeros(size(A));
s = {};
index = 1;

%Structuring Element
B = [0 1 1 0; 1 1 1 1; 1 1 1 1; 0 1 1 0];

%Generate Skeleton and Skeleton Sets
skeleton = zeros(size(A));
C = A;
nonempty = true;
while(nonempty)
    D = C;
    C = imerode(C, B);
    D = D & ~(imdilate(C, B));
    skeleton = skeleton | D;
    s{index} = D;
    index = index + 1;
    
    if(nnz(D) == 0) % check if the skeleton set is empty
        nonempty = false;
    end
end

imwrite(skeleton, 'skeleton.png');
result = zeros(size(A));
% Reconstruct the original image
lower_threshold = 1; % Lowest set to use for partial reconstruction
index = length(s);
for i = index: -1: lower_threshold
    result = imdilate((result | s{i}), B);
end
filepath = strcat('reconstruction-lowest-', string(lower_threshold),'.png');
imwrite(result, filepath);


