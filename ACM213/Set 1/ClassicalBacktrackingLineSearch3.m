f = @(x) 100.*(x(2)-x(1).^2).^2+(1-x(1)).^2 + 100.*(x(3)-x(2).^2).^2 + (1-x(2)).^2;
df = @(x) [2.*(x(1)-1+200.*x(1).^3-200.*x(1).*x(2)); -2-200.^x(1).^2+400.*x(2).^3+x(2).*(202-400.*x(3)); 200.*(-x(2).^2+x(3))];
xk = [-0.3,-0.3,-0.3];
pk = [1;1;-1];
mu1 = 1e-4;
rho = 0.7;

phi = @(a) f(xk+a.*pk);

alf0 = 2;
[ct,alf1, ahist1] = backtracking(f,df,xk,pk,mu1,alf0,rho);

figure;
fplot(phi,[0 2]);
xlabel('alpha');
ylabel('f');
hold on;
scatter(ahist1,arrayfun(phi,ahist1));
title("Backtracking from (-0.3,-0.3,-0.3) with pk=(1,1,-1).");