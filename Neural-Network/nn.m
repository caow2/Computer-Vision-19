function net = nn()
% Return randomly initialized network 
% weight matrices are (neurons, input size)
W1 = randn(64, 64); 
W2 = randn(16, 64);
W3 = randn(4, 16);

% Bias
b1 = 1;
b2 = 1;
b3 = 1;

net = struct('W1', W1, 'W2', W2, 'W3', W3, 'b1', b1, 'b2', b2, 'b3', b3);
end