function net = training(net, iterations, learn_rate, x, y)
disp('Iteration number and Error');
for it=1:iterations
   % Train over all training images each iteration
   e = 0;
   for img = 1 : size(x,1)
       train_img = x(img, :).';
       train_label = y(img, :).';
       [net, err] = updateWeights(net, train_img, train_label, learn_rate); % Error after adjusting weights
       e = e + err;
   end
   e = e / size(x, 1); % average error
   disp(sprintf('Iteration %d : %f', it, err)); 
end
end