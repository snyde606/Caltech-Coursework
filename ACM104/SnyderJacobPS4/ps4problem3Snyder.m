load carbig;
data = [Weight, Horsepower, MPG];
data(any(isnan(data), 2), :) = [];

A = [ones(length(data),1), data(:,1), data(:,2), data(:,1).*data(:,2)];

x = inv(A'*A)*A'*data(:,3);
disp(x);

f = @(x1, x2) x(1) + x(2)*x1 + x(3)*x2 + x(4)*x1*x2;

fsurf(f);
hold on;
scatter3(Weight, Horsepower, MPG, 'filled');
hold off;