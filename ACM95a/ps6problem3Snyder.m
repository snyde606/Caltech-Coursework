tspan=[1,2];
F=@(t,Y) [Y(2); (3.*t.^2-1+2.*Y(1))./(t.^2)];
Y0=[3;0];
[t,Y]=ode45(F,tspan,Y0);
y=Y(:,1);

byhand=@(t) t.^2.*log(abs(t))+0.5.*t.^2+2./t+0.5;

figure
plot(t, byhand(t), 'r-o');
hold on;
plot(t, y, 'b-x');
legend('Exact','Numerical');

err = abs(byhand(t)-y);


figure
semilogy(t, err, 'b-x');