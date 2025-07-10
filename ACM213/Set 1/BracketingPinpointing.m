f = @(x) 0.1.*x(1).^6 - 1.5.*x(1).^4 + 5.*x(1).^2 + 0.1.*x(2).^4 + 3.*x(2).^2 - 9.*x(2) + 0.5.*x(2).*x(1);
df = @(x) [0.6.*x(1).^5 - 6.*x(1).^3 + 10.*x(1) + 0.5.*x(2); 0.4.*x(2).^3 + 6.*x(2) - 9 + 0.5.*x(1)];
xk = [-1.25; 1.25];
pk = [4; 0.75];
ainit = 0.05;

phi = @(a) f(xk+a.*pk);
phip = @(a) df(xk+a.*pk)'*pk;

phi0 = phi(0);
phip0 = phip(0);

mu1 = 1e-4;
mu2 = 1e-3;
sigma = 1.5;
astar1 = bracketing(f, df,xk,pk, ainit,phi0,phip0,mu1,mu2,sigma);

mu1 = 0.5;
mu2 = 0.8;
sigma = 2;
astar2 = bracketing(f, df,xk,pk, ainit,phi0,phip0,mu1,mu2,sigma);

figure;
fplot(phi,[0 1.2]);
ylim([-10 30]);
xlabel('alpha');
ylabel('f');
hold on;
scatter(astar1,phi(astar1));

figure;
fplot(phi,[0 1.2]);
ylim([-10 30]);
xlabel('alpha');
ylabel('f');
hold on;
scatter(astar2,phi(astar2));