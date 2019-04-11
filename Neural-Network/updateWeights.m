function [net,err] = updateWeights(net, x, y, learn_rate)
% y1, y2 are raw outputs from Layer 1 and 2 -> before applying sigmoid
% output is activated output from Layer 3
[y1, y2, output] = feedforward(net, x);

delta3 = (output - y); % 4 x 1
delta2 = sigmoidPrime(y2) .* (net.W3.' * delta3); % 16 x 1
delta1 = sigmoidPrime(y1) .* (net.W2.' * delta2); % 64 x 1

net.W3 = net.W3 + (-1 * learn_rate * delta3 * sigmoid(y2.'));
net.W2 = net.W2 + (-1 * learn_rate * delta2 * sigmoid(y1.')); 
net.W1 = net.W1 + (-1 * learn_rate * delta1 * sigmoid(x.'));

% Evaluate error/cost using new weights
[y1, y2, output] = feedforward(net, x);
err = networkError(output, y);


end