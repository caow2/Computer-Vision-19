function e = networkError(output, y)
% Calculate error based on the network output ypred and true output y.
diff = (y - output);
e = -(1/2) * dot(diff, diff); % -1/2 * sum(expected - actual) ^2
end