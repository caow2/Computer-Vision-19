k = 20; % number of dimensions to use

people = [1 2 3];
[X, XLabel, Y, YLabel] = load_images(people);
% calculate mean image and subtract
mu = mean(X, 2);
X = X - mu;
covX = (1 / size(X, 2)) * (X * X.'); % 10000 x 10000
[P, D] = eig(covX);

X = P.' * X;
X = X(end - k + 1:end, :); % Only keep first 20 features for each transformed vector

% Test on Y images
Y = Y - mu; % is it right to subtract mu of the X from Y
Y = P.' * Y;
Y = Y(end - k + 1:end, :);

% Nearest neighbor with training images X
for y = 1:size(Y, 2)
    % Keep track of closest image
    min_diff = inf;
    x_idx = -1;
    for x = 1:size(X, 2)
        diff = norm(X(:,x) - Y(:,y));
        if( diff < min_diff )
            min_diff = diff;
            x_idx = x; % Update closest image label
        end
    end
    fprintf("Target: %d, Prediction: %d\n", YLabel(y), XLabel(x_idx));
end

