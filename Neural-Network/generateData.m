function d = generateData()
path = './image/';
folders = {'dog','cat', 'bird', 'dolphin'};
x = zeros(20, 64); % 20 examples, each with 1 x 64
y = zeros(20, 4); % each y label is 1 x 4

% Generate x, y data set
index = 1;
for i = 1:size(folders,2)
    for img = 1:5
        imgpath = char(strcat(path,folders(i),'/',folders(i),num2str(img),'.png'));
        img = imread(imgpath);
        img = ~(im2bw(img));
        imshow(img);
        
        x(index,:) = extractFeature(img);
        y(index,:) = zeros(1,4);
        y(index,i) = 1; % set label
        index = index + 1;
    end
end


filename = 'data.mat';
save(filename, 'x','y');
disp('Finished generating data');
end