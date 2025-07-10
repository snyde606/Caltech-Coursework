% Results: We are seeing an order of convergence of roughly first order in
% h (halving h halves the error) which doesn't match very well with the
% theoretical 4th order accuracy.

f=@(x,t) sin(x-t);
exactsoln=@(x,t) sin(x-t)+t.*sin(x-t);

h_norm=@(v,h) sqrt(h.*sum(v.^2));

ps=[2 3 4 5 6 7 8];
error_log = zeros(size(ps));
num_order_log = zeros(1,6);
for p_index=1:7
    p=ps(p_index);
    h  = 2.*pi.*2.^(-p);
    k=2.^(-8);
    mu=k./h;
    t = [0:k:1];
    t_len = size(t,2)-1;
    x = [0:h:2.*pi];
    x_len = size(x,2)-1;

    dm = [ones(x_len,1).*(-1)];
    d0 = [ones(x_len+1,1).*9];
    dp = [ones(x_len,1).*9];
    dp2 = [ones(x_len-1,1).*(-1)];
    A = diag(d0)+diag(dm,-1)+diag(dp,1)+diag(dp2,2);
    A(1,end)=-1;
    A(end-1,1)=-1;
    A(end,1:2)=[9,-1];
    A=A./k;
    
    dm = [ones(x_len,1).*(1)];
    d0 = [ones(x_len+1,1).*(-27)];
    dp = [ones(x_len,1).*27];
    dp2 = [ones(x_len-1,1).*(-1)];
    B = diag(d0)+diag(dm,-1)+diag(dp,1)+diag(dp2,2);
    B(1,end) = 1;
    B(end-1,1) = -1;
    B(end,1:2) = [27,-1];
    B=B./k;

    u0 = sin(x);
    u0=u0';

    timer = 0;
    for i=1:t_len
        AL = 1./16.*A+mu./48.*B;
        BR = 1./16.*A-mu./48.*B;
        fterm = f(x,timer+k)+f(x,timer);
        BR = BR*u0 + (k./32.*A)*(fterm');
        
        u0 = AL\BR;

        timer = timer + k;
    end
    figure;
    plot(x,u0);
    hold on;
    exsoln=exactsoln(x,1);
    plot(x,exsoln');
    legend("numerical soln","exact soln");
    
    error = h_norm(u0-exsoln',h);
    error_log(p_index) = error;
    
    if p_index ~= 1
        num_order = log2(error_log(p_index-1)./error);
        num_order_log(p_index-1) = num_order;
    end
end