beta=15;
f = @(x) x(1).^2+beta.*x(2).^2;
df = @(x) [2.*x(1); 2.*beta.*x(2)];
xk = [10;1];
fproxy = @(x1,x2) f([x1;x2]);
lastxk=[0;0];

mu1 = 1e-3;
mu2 = 1e-2;
sigma = 2;

xkhistory = [xk];
dfk = df(xk);
xkgrad_history = [dfk];
losshistory = [f(xk)];
ct1=0;
pk = -dfk./norm(dfk);
while norm(xk-lastxk) > 1e-3
    
    ct1 = ct1+1;
    if ct1~=1
        betak=(dfk'*dfk)./(lastdfk'*lastdfk);
        pk=-(dfk./norm(dfk))+betak*pk;
    end
    
    phi = @(a) f(xk+a.*pk);
    phip = @(a) df(xk+a.*pk)'*pk;
    phi0 = phi(0);
    phip0 = phip(0);

    [ct,astar1] = bracketing(f, df,xk,pk, ainit,phi0,phip0,mu1,mu2,sigma);
    lastxk = xk;
    xk = xk+astar1.*pk;
    lastdfk = dfk;
    dfk = df(xk);
    
    xkhistory = [xkhistory, xk];
    xkgrad_history = [xkgrad_history, dfk];
    losshistory = [losshistory, f(xk)];
    
end

figure;
fcontour(fproxy,[-1 11 -2 2]);
xlabel('x1');
ylabel('x2');
hold on;
scatter(xkhistory(1,:), xkhistory(2,:));
title("CG beta=15, Bracketing/Pinpointing from (10,1). Mu1=1e-2, Mu2=0.3, sigma=2");