% It appears that the scheme only functions well for mu=0.1. The wave front
% is tracked significantly worse using this scheme than the previous ones.

f=@(u) 0.5.*u.^2;
a=1;
c=1;
x0=-0.5;

mus=[1 0.5 0.1];
for mu_index=1:3
    mu = mus(mu_index);
    h  = 0.1;
    k=h.*mu;
    mu = k/h;
    t = [0:k:1];
    t_len = size(t,2)-1;
    x = [-1:h:1];
    x_len = size(x,2)-1;

    u0 = a-sign(x-x0).*c;

    for i=1:t_len
        u0(1) = u0(3);
        u0(end) = u0(end-2);
        newu = u0;
        
        newu(2:end-1) = newu(2:end-1) - 0.5.*mu.*f(u0(2:end-1)) + 0.5.*mu.*f(u0(1:end-2));
        aplus = 0.5.*(u0(2:end-1)+u0(3:end));
        aminus = 0.5.*(u0(2:end-1)+u0(1:end-2));
        newu(2:end-1) = newu(2:end-1) + 0.5.*mu.^2.*(aplus.*(f(u0(3:end))-f(u0(2:end-1)))-aminus.*(f(u0(2:end-1))-f(u0(1:end-2))));
        
        u0 = newu;
        u0(1) = u0(3);
        u0(end) = u0(end-2);
    end
    
    figure;
    plot(x,a-sign(x-a-x0));
    hold on;
    plot(x,u0);
end