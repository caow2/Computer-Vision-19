function label = classifyImage(net, img)
% Classify an image using the specified network 
labels = {'dog','cat', 'bird', 'dolphin'};
x = extractFeature(img);

ypred = classify(net, x.');
[argmax, argmax_idx] = max(ypred);
label = labels(argmax_idx);
end