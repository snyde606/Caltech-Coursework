f = @(x) (1-x(1)).^2 + (1-x(2)).^2 + 0.5.*(2.*x(2)-x(1).^2).^2;
df = @(x) [2.*x(1).^3 + x(1).*(2-4.*x(2))-2;-2.*x(1).^2+6.*x(2)-2];
xk = [1.6,1.3];
pk = [-1;1];
ainit = 0.05;

phi = @(a) f(xk+a.*pk);
phip = @(a) df(xk+a.*pk)'*pk;

phi0 = phi(0);
phip0 = phip(0);

mu1 = 1e-4;
mu2 = 1e-3;
sigma = 1.5;
[ct,astar1] = bracketing(f, df,xk,pk, ainit,phi0,phip0,mu1,mu2,sigma);

figure;
fplot(phi,[0 2]);
xlabel('alpha');
ylabel('f');
hold on;
scatter(astar1,phi(astar1));
title("Bracketing/Pinpointing from (1.6,1.3) with pk=(-1,1).");