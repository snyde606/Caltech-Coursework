N = 500;
m = 1000;
x_bounds = [-2, 1];
y_bounds = [-1.5, 1.5];

X = linspace(x_bounds(1), x_bounds(2), m);
Y = linspace(y_bounds(1), y_bounds(2), m);

[X_grid, Y_grid] = meshgrid(X, Y);
[X_grid_0, Y_grid_0] = meshgrid(X, Y);
k_grid = -1.*ones(m);

abs_grid = sqrt(X_grid.^2 + Y_grid.^2);
k_grid = k_grid + (abs_grid>2 & k_grid==-1);

for i = 2:N
    next_X_grid = X_grid.^2 - Y_grid.^2 + X_grid_0;
    next_Y_grid = 2.*X_grid.*Y_grid + Y_grid_0;
    
    X_grid = next_X_grid;
    Y_grid = next_Y_grid;
    abs_grid = sqrt(X_grid.^2 + Y_grid.^2);
    
    k_grid = k_grid + i .* (abs_grid>2 & k_grid==-1);
end

k_grid = k_grid + (N+1) .* (k_grid==-1);

figure;
imagesc(X, Y, k_grid);
axis equal;
axis([-2, 1, -1.5, 1.5]);



N = 500;
m = 1000;
x_bounds = [-0.748766713922161, -0.748766707771757];
y_bounds = [0.123640844894862, 0.123640851045266];

X = linspace(x_bounds(1), x_bounds(2), m);
Y = linspace(y_bounds(1), y_bounds(2), m);

[X_grid, Y_grid] = meshgrid(X, Y);
[X_grid_0, Y_grid_0] = meshgrid(X, Y);
k_grid = -1.*ones(m);

abs_grid = sqrt(X_grid.^2 + Y_grid.^2);
k_grid = k_grid + (abs_grid>2 & k_grid==-1);

for i = 2:N
    next_X_grid = X_grid.^2 - Y_grid.^2 + X_grid_0;
    next_Y_grid = 2.*X_grid.*Y_grid + Y_grid_0;
    
    X_grid = next_X_grid;
    Y_grid = next_Y_grid;
    abs_grid = sqrt(X_grid.^2 + Y_grid.^2);
    
    k_grid = k_grid + i .* (abs_grid>2 & k_grid==-1);
end

k_grid = k_grid + (N+1) .* (k_grid==-1);

figure;
imagesc(X, Y, k_grid);
axis equal;
axis([-0.748766713922161, -0.748766707771757, 0.123640844894862, 0.123640851045266]);