function s = sigmoidPrime(x)
% Suppose x is n x 1
s = sigmoid(x) .* (1 - sigmoid(x));
end