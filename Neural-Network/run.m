% Load data, train a new neural network, and save it in nn.mat
data = load('data.mat');
x = data.x;
y = data.y;

% Randomly split into training and testing data
test_proportion = .3;
partition = cvpartition(size(x,1), 'HoldOut', test_proportion);

xtrain = x(partition.training, :);
xtest = x(partition.test, :);
ytrain = y(partition.training, :);
ytest = y(partition.test, :);

% Train neural network
net = nn();
net = training(net, 1000, .001, xtrain, ytrain);

% Test on training set
labels = {'dog','cat', 'bird', 'dolphin'};
ypred = classify(net, xtest);

% Compare predicted output and actual test set
disp(ypred);
disp(ytest);

save('nn.mat', 'net');