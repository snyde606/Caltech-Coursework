m=10;
beta=15;
n=2;
f = @(x) x(1).^2+beta.*x(2).^2;
df = @(x) [2.*x(1); 2.*beta.*x(2)];
xk = [10;1];
fproxy = @(x1,x2) f([x1;x2]);
lastxk=[0;0];
pk = ones(n,1);

ainit = 0.1;

mu1 = 1e-3;
mu2 = 1e-2;
sigma = 2;

dummyxk = -1000.*ones(n,1);
xkhistory = [xk];
dfk = df(xk);
xkgrad_history = [dfk];
losshistory = [f(xk)];
ct1=0;
Vk = 1./norm(df(xk)).*eye(n);
while norm(xk-lastxk) > 1e-3
    
    ct1 = ct1+1;
    a = zeros(size(xkhistory));
    for j=1:min(ct1,m)
        i=ct1-j+1;
        if i==1
            s=xkhistory(:,1)-dummyxk;
            y=xkgrad_history(:,1)-df(dummyxk);
            sig=1./(s'*y);
        else
            s=xkhistory(:,i)-xkhistory(:,i-1);
            y=xkgrad_history(:,i)-xkgrad_history(:,i-1);
            sig=1./(s'*y);
        end
        a(i)=sig*s'*dfk;
        dfk=dfk-a(i)*y;
    end
    
    if ct1==1
        slast=xkhistory(:,1)-dummyxk;
        ylast=xkgrad_history(:,1)-df(dummyxk);
    else
        slast = xkhistory(:,end)-xkhistory(:,end-1);
        ylast = xkgrad_history(:,end)-xkgrad_history(:,end-1);
    end
    V0=(slast'*ylast)/(ylast'*ylast)*eye(n);
    dfk = V0*dfk;
    
    for i=max(1,ct1-m+1):ct1
        if i==1
            s=xkhistory(:,1)-dummyxk;
            y=xkgrad_history(:,1)-df(dummyxk);
            sig=1./(s'*y);
        else
            s=xkhistory(:,i)-xkhistory(:,i-1);
            y=xkgrad_history(:,i)-xkgrad_history(:,i-1);
            sig=1./(s'*y);
        end
        b=sig*y'*dfk;
        dfk=dfk+(a(i)-b)*s;
    end
    
    pk = -dfk;
    phi = @(a) f(xk+a.*pk);
    phip = @(a) df(xk+a.*pk)'*pk;
    phi0 = phi(0);
    phip0 = phip(0);

    [ct,astar1] = bracketing(f, df,xk,pk, ainit,phi0,phip0,mu1,mu2,sigma);
    lastxk = xk;
    xk = xk+astar1.*pk;
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
title("L-BFGS m=10 beta=15, Bracketing/Pinpointing from (10,1). Mu1=1e-2, Mu2=0.3, sigma=2");