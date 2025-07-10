f = @(x) 100.*(x(2)-x(1).^2).^2+(1-x(1)).^2;
df = @(x) [2.*(200.*x(1).^3-200.*x(1).*x(2)+x(1)-1); 200.*(x(2)-x(1).^2)];
fproxy = @(x1,x2) f([x1;x2]);
xk = [-1;2];
pk = [1;1];

ainit = 0.1;



mu1 = 1e-3;
mu2 = 1e-2;
sigma = 2;

lastxk = [-1000;-1000];
xkhistory = [xk];
ct1=0;
Vk = 1./norm(df(xk)).*eye(2);
while norm(xk-lastxk) > 1e-3
    
    dfk = df(xk);
    s=xk-lastxk;
    y=dfk-df(lastxk);
    sig=1./(s'*y);
    Vk = (eye(2)-sig*s*y')*Vk*(eye(2)-sig*y*s')+sig*s*s';
    pk = -Vk*dfk;
    phi = @(a) f(xk+a.*pk);
    phip = @(a) df(xk+a.*pk)'*pk;
    phi0 = phi(0);
    phip0 = phip(0);

    [ct,astar1] = bracketing(f, df,xk,pk, ainit,phi0,phip0,mu1,mu2,sigma);
    lastxk = xk;
    xk = xk+astar1.*pk;
    
    xkhistory = [xkhistory, xk];
    ct1 = ct1+1;
end

figure;
fcontour(fproxy,[-2 2 -1 3]);
xlabel('x1');
ylabel('x2');
hold on;
scatter(xkhistory(1,:), xkhistory(2,:));
title("BFGS, Bracketing/Pinpointing from (-1,2). Mu1=1e-2, Mu2=0.3, sigma=2");