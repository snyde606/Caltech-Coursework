N = 300;
gamma = @(t) [(1+0.3.*cos(5.*t)).*cos(t); (1+0.3.*cos(5.*t)).*sin(t)]; %parametrization
gammadot = @(t) [(-1-0.3.*cos(5.*t)).*sin(t)-1.5.*cos(t).*sin(5.*t); cos(t)+0.3.*cos(t).*cos(5.*t)-1.5.*sin(t).*sin(5.*t)];
gammadotdot = @(t) [cos(t).*(-1-7.8.*cos(5.*t))+3.*sin(t).*sin(5.*t); (-1-7.8.*cos(5.*t)).*sin(t)-3.*cos(t).*sin(5.*t)];

%1 Discretization
ts = linspace(0,2.*pi-2.*pi/N,N);

%2 construct D
D = zeros(N,N);
for i=1:N
   for j=1:N
       a = gammadotdot(ts(j));
       b = gammadot(ts(j));
       b = [-b(2) b(1)];
       vy = -dot(a,b)./dot(b,b).*b;
       if i==j
           D(i,i) = (vy*gamma(ts(i)))./(2.*N.*norm(gammadot(ts)));
       end
       if i~=j
           D(i,j) = vy*((gamma(ts(j))-gamma(ts(i)))./(norm(gamma(ts(i))-gamma(ts(j))).^2)).*norm(gammadot(ts))./N;
       end
   end
end

%3 construct f
f = cos(cos(ts).*(1 + 0.3.*cos(5.*ts))).*cosh((1 + 0.3.*cos(5.*ts)).*sin(ts));

%4 solve for phi
phi = (eye(N)+2.*D)\f';

%5 plot results
figure
plot(phi')
hold on;
plot(f)

xs = gamma(ts);
figure
plot3(xs(1,:),xs(2,:),f)
figure
plot3(xs(1,:),xs(2,:),phi')