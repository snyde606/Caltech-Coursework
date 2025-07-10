% The dissipation relation is <=1, and we can see that the magnitude of the
% solution does not appear to be increasing - however it's non-obvious that
% it is decreasing either (it's hard to tell because of how much it
% oscillates; maybe we could take an integral over the domain to see if the
% "average amplitude" has changed?). This is in line with the dissipation relation.
% We can see that the phase appears to be approximately on track, which is
% in line with our phase speed/dispersion relation being near 1.

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

    dm = [ones(x_len,1).*(-0.5.*mu)];
    d0 = [ones(x_len+1,1)];
    dp = [ones(x_len,1).*(0.5.*mu)];
    A = diag(d0)+diag(dm,-1)+diag(dp,1);

    u0 = x<0.5; % note - exact solution at t=3 is equivalent to the initial condition
    b=u0';

    for i=1:t_len
        b(1)=b(end);
        b = A\b;

    end
    figure;
    plot(x,b);
    hold on;
    plot(x,u0);
    
    error = norm(b-u0);
    error_log(p_index) = error;
end