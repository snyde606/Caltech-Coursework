f = @(x) 100.*(x(2)-x(1).^2).^2+(1-x(1)).^2;
df = @(x) [2.*(200.*x(1).^3-200.*x(1).*x(2)+x(1)-1); 200.*(x(2)-x(1).^2)];
fproxy = @(x1,x2) f([x1;x2]);
xk = [-1;2];
pk = -df(xk)./norm(df(xk));

ainit = 0.1;

phi = @(a) f(xk+a.*pk);
phip = @(a) df(xk+a.*pk)'*pk;

phi0 = phi(0);
phip0 = phip(0);

mu1 = 1e-6;
mu2 = 1e-4;
sigma = 2;

lastxk = -1000;
xkhistory = [xk];
ct1=0;
while abs(xk-lastxk) > 1e-2
    
    pk = -df(xk)./norm(df(xk));
    [ct,astar1] = bracketing(f, df,xk,pk, ainit,phi0,phip0,mu1,mu2,sigma);
    lastxk = xk;
    xk = xk+astar1.*pk;
    phi = @(a) f(xk+a.*pk);
    phip = @(a) df(xk+a.*pk)'*pk;
    phi0 = phi(0);
    phip0 = phip(0);
    xkhistory = [xkhistory, xk];
    ct1 = ct1+1;
end

figure;
fcontour(fproxy,[-2 2 -1 3]);
xlabel('x1');
ylabel('x2');
hold on;
scatter(xkhistory(1,:), xkhistory(2,:));
title("Steepest Descent, Bracketing/Pinpointing from (-1,2). Mu1=1e-6, Mu2=1e-4, sigma=2");