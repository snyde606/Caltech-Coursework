f = @(x) -x./(x.^2+2);
df = @(x) (x.^2-2)./(x.^2+2).^2;
xk = 30;
pk = -20.*df(xk);

mu1 = 1e-2;
rho = 0.9;

phi = @(a) f(xk+a.*pk);

alf0 = 1;
lastxk = -1000;
xkhistory = [xk];
while abs(xk-lastxk) > 1e-2
    
pk = -20.*df(xk);
    [ct,alf1,ahist1] = backtracking(f,df,xk,pk,mu1,alf0,rho);
    disp(ahist1);
    lastxk = xk;
    xk = xk+alf1.*pk;
    phi = @(a) f(xk+a.*pk);
    xkhistory = [xkhistory xk];
end

figure;
fplot(f,[0 10]);
xlabel('xk');
ylabel('f');
hold on;
scatter(xkhistory,arrayfun(f,xkhistory));
title("Backtracking from 0. Mu1=1e-4, rho=0.9, alf0=1");