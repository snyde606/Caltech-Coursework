f = @(x) 0.1.*x(1).^6 - 1.5.*x(1).^4 + 5.*x(1).^2 + 0.1.*x(2).^4 + 3.*x(2).^2 - 9.*x(2) + 0.5.*x(2).*x(1);
df = @(x) [0.6.*x(1).^5 - 6.*x(1).^3 + 10.*x(1) + 0.5.*x(2); 0.4.*x(2).^3 + 6.*x(2) - 9 + 0.5.*x(1)];
xk = [-1.25; 1.25];
pk = [4; 0.75];
mu1 = 1e-4;
rho = 0.7;

phi = @(a) f(xk+a.*pk);

alf0 = 1.2;
[alf1, ahist1] = backtracking(f,df,xk,pk,mu1,alf0,rho);

alf0 = 0.05;
[alf2, ahist2] = backtracking(f,df,xk,pk,mu1,alf0,rho);

figure;
fplot(phi,[0 1.2]);
ylim([-10 30]);
xlabel('alpha');
ylabel('f');
hold on;
scatter(ahist1,arrayfun(phi,ahist1));

figure;
fplot(phi,[0 1.2]);
ylim([-10 30]);
xlabel('alpha');
ylabel('f');
hold on;
scatter(ahist2,arrayfun(phi,ahist2));