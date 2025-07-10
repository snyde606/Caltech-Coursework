n=50;
alpha=5;
m=20;
f = @(x) f_n(x,n,alpha);
df = @(x) grad_f_n(x,n,alpha);
xk = -1.*ones(n,1);
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
scatter(linspace(1,size(xkhistory,2),size(xkhistory,2)),log(losshistory));
xlabel('iteration #');
ylabel('ln(loss function)');
hold on;
title("L-BFGS n=50 m=1 alpha=5, Bracketing/Pinpointing from (-1,-1, ... ,-1). Mu1=1e-2, Mu2=0.3, sigma=2");

function res = f_n(x,n,alpha)
    t_func = @(x,i,alpha) alpha.*(x(i+1) -x(i).^2).^2 + (1-x(i)).^2;
    val_array = t_func(x,linspace(1,n-1,n-1),alpha);
    res = sum(val_array);
end

function res = grad_f_n(x,n,alpha)
    t_func = @(x,i,alpha) 2.*(alpha.*(-x(i-1).^2+2.*x(i).^3-2.*x(i).*x(i+1)+x(i))+x(i)-1);
    val_array = t_func(x,linspace(2,n-1,n-2)',alpha);
    val1 = 2.*(alpha.*2.*x(1).^3 - alpha.*2.*x(1).*x(2)+x(1)-1);
    val_end = 2.*alpha.*(x(n)-x(n-1).^2);
    res = [val1; val_array; val_end];
end