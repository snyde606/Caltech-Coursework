f=@(t,y) (t.^2-y.^2).*sin(y);
xs = linspace(0,1,41);

explicit_euler = [1];
heun = [1];
del = 0.025;

%Explicit Euler approximation
for a = 1:40
    last_val = explicit_euler(end);
    next_val = last_val + del.*f(xs(length(explicit_euler)), last_val);
    explicit_euler = [explicit_euler next_val];
end

%Heun approximation
for a = 1:40
    last_val = heun(end);
    next_val = last_val + (del./2).*(f(xs(length(heun)), last_val)+f(xs(length(heun)+1), last_val+del.*f(xs(length(heun)), last_val)));
    heun = [heun next_val];
end

%ode45 approximation
tspan=[0, 1];
y0 = 1.0;
[t,y]=ode45(f,tspan,y0);

%Plotting
figure
hold on;
plot(t, explicit_euler, 'r-o');
plot(t, heun, 'g-o');
plot(t, y, 'b-x');

legend('Explicit Euler','Heun','ode45 approximation');

%ERROR PLOTTING
%err = abs(byhand(tcom)-ycom);

%figure
%semilogy(tcom, err, 'b-x');