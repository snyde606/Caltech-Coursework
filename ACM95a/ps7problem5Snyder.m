f=@(t,y) (y.^2+2.*t.*y)./(3+t.^2);
byhand = @(t) (3+t.^2)./(6-t);
xs = linspace(0,1,41);

rk = [0.5];
del = 0.025;

%Runge-Kutta approximation
for a = 1:40
    last_val = rk(end);
    k1 = f(xs(length(rk)), last_val);
    k2 = f(xs(length(rk))+del./2, last_val+del.*k1./2);
    k3 = f(xs(length(rk))+del./2, last_val+del.*k2./2);
    k4 = f(xs(length(rk))+del, last_val+del.*k3);
    next_val = last_val + del.*(k1+2.*k2+2.*k3+k4)./6;
    rk = [rk next_val];
end

%ode45 approximation
%tspan=[0, 1];
%y0 = 0.5;
%[t,y]=ode45(f,tspan,y0);

%Plotting
%figure
%hold on;
%plot(xs, rk, 'g-o');
%plot(xs, byhand(xs), 'b-x');

%legend('Runge-Kutta','Exact Solution');

%ERROR PLOTTING
err = abs(byhand(xs)-rk);

figure
plot(xs, err, 'b-x');