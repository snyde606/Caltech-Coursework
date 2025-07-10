lambda = 0.8;
hs = [1./10 1./20 1./40];

error_log = [];
for h_index=1:3
    h=hs(h_index);
    k=lambda.*h; %timestep
    xs_size = 4./h+1;
    start_space = linspace(-1,3,xs_size);

    temp = (start_space>=-0.5) & (start_space<=0.5);
    temp = temp.*cos(pi.*start_space).^2;
    u0=temp;
    
    gapsz = 2.4; %shift for exact_soln (should be 2.4*0.8 but that doesn't line up for some reason)
    temp = (start_space>=-0.5+gapsz) & (start_space<=0.5+gapsz);
    temp = temp.*cos(pi.*(start_space-gapsz)).^2;
    exact_soln=temp;
    
    last_endm1 = u0(end);
    
    t = 0;
    u = zeros(1,xs_size);
    while t < 2.4
        u0(1)=0;
        u0(end) = last_endm1;
        last_endm1 = u0(end-1);

        %Lax-Friedrichs
        for j=2:xs_size-1
            u(j) = 0.5.*(u0(j+1) + u0(j-1)) - 0.4.*(u0(j+1) - u0(j-1));
        end

        u0 = u;
        t = t+k;
    end

    error = norm(u0-exact_soln);
    error_log = [error_log error];
    
    figure;
    plot(u0);
    hold on;
    plot(exact_soln);
    title("Lax-Friedrichs, h="+h);
end

beta_hs = [0 0];
beta_hs(1) = log2(abs(error_log(1)./error_log(2)));
beta_hs(2) = log2(abs(error_log(2)./error_log(3)));
disp("numerical order");
disp(beta_hs);
disp("error log:");
disp(error_log);