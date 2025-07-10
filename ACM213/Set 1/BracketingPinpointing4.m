f = @(x) -x./(x.^2+2);
df = @(x) (x.^2-2)./(x.^2+2).^2;
xk = 30;
pk = -20.*df(xk);

ainit = 0.1;

phi = @(a) f(xk+a.*pk);
phip = @(a) df(xk+a.*pk)'*pk;

phi0 = phi(0);
phip0 = phip(0);

mu1 = 1e-4;
mu2 = 1e-3;
sigma = 2;

lastxk = -1000;
xkhistory = [xk];
ct1=0;
while abs(xk-lastxk) > 1e-2
    
    [ct,astar1] = bracketing(f, df,xk,pk, ainit,phi0,phip0,mu1,mu2,sigma);
    lastxk = xk;
    xk = xk+astar1.*pk;
    phi = @(a) f(xk+a.*pk);
    phip = @(a) df(xk+a.*pk)'*pk;
    phi0 = phi(0);
    phip0 = phip(0);
    xkhistory = [xkhistory xk];
    ct1 = ct1+1;
end

figure;
fplot(f,[0 30]);
xlabel('xk');
ylabel('f');
hold on;
scatter(xkhistory,arrayfun(f,xkhistory));
title("Bracketing/Pinpointing from 0. Mu1=1e-4, Mu2=1e-3, sigma=2. k=20");