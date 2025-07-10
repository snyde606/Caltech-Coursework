byhand = @(t) (t.^2).*1./4-t./3+0.5-(1./12).*(1./(t.^2));

tspan=[1, 0.2];
f=@(t,y) t - 1 + 1./t - (2./t .* y);
y0 = 1./3;

[t1,y1]=ode45(f,tspan,y0);

tspan = [1,2];

[t2,y2]=ode45(f,tspan,y0);

tcom = [flip(t1);t2(2:length(t2))]
ycom = [flip(y1);y2(2:length(y2))]

figure
plot(tcom, byhand(tcom), 'r-o');
hold on;
plot(tcom, ycom, 'b-x');
legend('Exact','Numerical');

err = abs(byhand(tcom)-ycom);


figure
semilogy(tcom, err, 'b-x');