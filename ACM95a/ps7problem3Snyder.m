f=@(t,y) (y.^2+2.*t.*y)./(3+t.^2);
xs = linspace(0,1,41);

explicit_euler = [0.5];
implicit_euler = [0.5];
del = 0.025;

%Explicit Euler approximation
for a = 1:40
    last_val = explicit_euler(end);
    next_val = last_val + del.*f(xs(length(explicit_euler)), last_val);
    explicit_euler = [explicit_euler next_val];
end

%Implicit Euler approximation
for a = 2:41
    tp1 = xs(a);
    yn = implicit_euler(end);
    p = [del del.*2.*tp1-3-(tp1.^2) 3.*yn+yn.*tp1.^2];
    next_val = min(roots(p));
    implicit_euler = [implicit_euler next_val];
end

%ode45 approximation
tspan=[0, 1];
y0 = 1./2;
[t,y]=ode45(f,tspan,y0);

%Plotting
figure
hold on;
plot(t, explicit_euler, 'r-o');
plot(t, implicit_euler, 'g-o');
plot(t, y, 'b-x');

legend('Explicit Euler','Implicit Euler','ode45 approximation');

%ERROR PLOTTING
%err = abs(byhand(tcom)-ycom);

%figure
%semilogy(tcom, err, 'b-x');