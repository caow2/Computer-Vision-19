% Evaluate trained neural net on provided dataset (20 images)
% and on additional dataset (12 images)
path = './image/';
folders = {'dog','cat', 'bird', 'dolphin'};

data = load('nn.mat');
net = data.net;

% Test on original
index = 1;
for i = 1:size(folders,2)
    for img = 1:5
        imgpath = char(strcat(path,folders(i),'/',folders(i),num2str(img),'.png'));
        img = imread(imgpath);
        img = ~(im2bw(img));
        imshow(img);
        disp(classifyImage(net, img));
    end
end

% Evaluate on new dataset
path = './test_image/';
index = 1;
for i = 1:size(folders,2)
    for img = 1:2
        imgpath = char(strcat(path,folders(i),'/',folders(i),num2str(img),'.png'));
        img = imread(imgpath);
        img = ~(im2bw(img));
        imshow(img);
        
        disp(classifyImage(net, img));
    end
end

