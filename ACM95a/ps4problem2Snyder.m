%version: 9.4.0.813654 (R2018a)
f = @(x) (1+x).^1i;
g = @(x) 1+1i*x-(1+1i)*x.^2./2;

data = randomDisk(0,1,1e4);

d = abs(f(data)-g(data));

scatter(real(data), imag(data), [], d, 'filled');
colorbar();