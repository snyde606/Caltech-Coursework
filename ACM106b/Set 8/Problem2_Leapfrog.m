% Once again, it is hard to determine what the average amplitude of the
% numerical method ends up being, but it is plausible that it is unchanged,
% which matches our finding of a dissipative relation of 1. Also, the phase
% is exactly in line with the exact solution, which is in line with our
% dispersive relation.

ps=[0 1 2 3 4 5];
error_log = zeros(size(ps));
for p_index=1:6
    p=ps(p_index);
    h  = 0.1.*2.^(-p);
    mu = 0.9;
    k=mu.*h;
    t = [0:k:3];
    t_len = size(t,2)-1;
    x = [0:h:1];
    x_len = size(x,2)-1;

    initial_data = x<0.5; % note - exact solution at t=3 is equivalent to the initial condition
    initial_data = double(initial_data);
    u0=initial_data;
    u1=u0;
    u1(1:end-1) = u1(1:end-1) - 0.5.*mu.*u0(2:end);
    u1(2:end) = u1(2:end) + 0.5.*mu.*u0(1:end-1);

    for i=1:t_len
        u0(1)=u0(end);
        u1(1)=u1(end);
        new = u0;
        new(1:end-1) = new(1:end-1) - mu.*u1(2:end);
        new(2:end) = new(2:end) + mu.*u1(1:end-1);
        u0=u1;
        u1=new;
        disp(u1);
    end
    figure;
    plot(x,u1);
    hold on;
    plot(x,initial_data);
    
    error = norm(u1-initial_data);
    error_log(p_index) = error;
end