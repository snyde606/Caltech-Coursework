% The scheme is not stable. The reason for this is that the amplification
% factor is >1.

f=@(u) 0.5.*u.^2;
a=1;
c=1;
x0=-0.5;
h  = 0.025;
k=0.01;
mu = k/h;
t = [0:k:1];
t_len = size(t,2)-1;
x = [-1:h:1];
x_len = size(x,2)-1;

u0 = a-sign(x-x0).*c;

for i=1:t_len
    newu = u0;
    newu(1) = newu(3);
    newu(end) = newu(end-2);
    newu(1:end-1) = newu(1:end-1)-k./(2.*h).*f(u0(2:end));
    newu(2:end) = newu(2:end)+k./(2.*h).*f(u0(1:end-1));
    u0 = newu;
end
figure;
plot(x,a-sign(x-a-x0));
figure;
plot(x,u0);