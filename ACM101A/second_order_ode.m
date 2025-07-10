function second_order_ode

t=0:0.001:30;   % time scale

initial_x    = 0;
initial_dxdt = 1;
eps = 0.01;

[t,x]=ode45( @rhs, t, [initial_x initial_dxdt] );

plot(t,x(:,1));
xlabel('t'); ylabel('x');
hold on;
fplot(@(x) -cos(pi./2 + x)./sqrt(3./4.*eps.*x + 1),[0 30]);
fplot(@(x) sin(x) + eps./32.*(12.*x.*cos(x) - 8.*sin(x).^5 - 8.*cos(x).*sin(2.*x) + cos(x).*sin(4.*x)),[0 30]);

    function dxdt=rhs(t,x)
        epsilon = 0.01;
        dxdt_1 = x(2);
        dxdt_2 = -epsilon*x(2).^3 - x(1);

        dxdt=[dxdt_1; dxdt_2];
    end
end