h  = 0.1;
k = 0.005;
mu = 0.5;
t = [0:k:10];
t_len = size(t,2)-1;
x = [-1:h:1];
x_len = size(x,2)-1;

dm = [ones(x_len,1).*(-0.5.*mu)];
d0 = [ones(x_len+1,1).*(1+mu)];
dp = [ones(x_len,1).*(-0.5.*mu)];
A = diag(d0)+diag(dm,-1)+diag(dp,1);

u0 = zeros(x_len+1, t_len+1);
u0(:,1) = 1-abs(x);

for i=1:t_len
    
    u0(2:end-1,i+1) = u0(2:end-1,i) + 0.5.*mu.*(u0(3:end,i) - 2.*u0(2:end-1,i) + u0(1:end-2,i));

    b = u0(:,i+1);
    u0(:,i+1) = A\b;
    u0(1,i+1) = 0;
    u0(end,i+1) = 0;
end
figure;
plot(x,u0(:,end));
