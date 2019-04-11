function [y1, y2, output] = feedforward(net, x)
% Return the raw output from Layer 1, 2, and the activated output of layer 3
y1 = (net.W1 * x) + net.b1;
y1a = sigmoid(y1);

y2 = (net.W2 * y1a) + net.b2;
y2a = sigmoid(y2);

output = (net.W3 * y2a) + net.b3;
output = sigmoid(output);
end