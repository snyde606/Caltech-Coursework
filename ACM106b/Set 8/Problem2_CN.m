% The amplitude of the solution appears to be relatively unchanged (again,
% it's hard to tell because of how oscillatory the solution is). This is in
% line with the dissipation relation of 1. We can also see that the phase
% appears to be exactly in line with the original solution which is in line
% with our dispersive relation near 1.

ps=[0 1 2 3 4 5];
error_log = zeros(size(ps));
for p_index=1:6
    p=ps(p_index);
    h  = 0.1.*2.^(-p);
    mu = 1;
    k=mu.*h;
    t = [0:k:3];
    t_len = size(t,2)-1;
    x = [0:h:1];
    x_len = size(x,2)-1;

    dm = [ones(x_len,1).*(-0.25.*mu)];
    d0 = [ones(x_len+1,1)];
    dp = [ones(x_len,1).*(0.25.*mu)];
    A = diag(d0)+diag(dm,-1)+diag(dp,1);

    u0 = x<0.5; % note - exact solution at t=3 is equivalent to the initial condition
    b=u0';

    for i=1:t_len
        b(1)=b(end);
        last = b;
        b(1:end-1) = b(1:end-1)-mu.*0.25.*last(2:end);
        b(2:end) = b(2:end)+mu.*0.25.*last(1:end-1);
        b=A\b;
    end
    figure;
    plot(x,b);
    hold on;
    plot(x,u0);
    
    error = norm(b-u0);
    error_log(p_index) = error;
end