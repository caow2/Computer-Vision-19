function labels = classify(net, x)
% Classify an feature vector on a trained network
% input x is 1 x 64
labels = zeros(size(x,1), 4);

for i = 1:size(x,1)
    [y1,y2,output] = feedforward(net, x(i,:).');
    [argmax, argmax_idx] = max(output);

    label = zeros(1,4);
    label(argmax_idx) = 1;
    labels(i,:) = label;
end
end