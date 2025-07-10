ms=[4 5 6 7 8 9];
for m_index=1:6
    m=ms(m_index);
    n=2.^m;
    h=1/n;
    x = ((1:n-1)*h)';
    f = 4.*pi.^2.*cos(2.*pi.*x);
    exact_soln = cos(2.*pi.*x)-1;
    u0 = zeros(size(f));
    e = ones(n-1,1);
    A = spdiags([-e,2*e,-e],[-1,0,1],n-1,n-1);
    A = 1./h.^2.*A;
    initial_r = norm(A*u0-f,2);
    iteration_r = initial_r;
    ct = 0;
    while iteration_r./initial_r > 1e-8
        ct = ct + 1;
        u0 = multigrid(f,u0);
        iteration_r = norm(A*u0-f,2);
    end
    max_norm_error = norm(u0-exact_soln, Inf);
    disp(" ");
    disp("For n=" + n + ":");
    disp("Final residual: " + iteration_r);
    disp("Multigrid iteration count: " + ct);
    disp("Max-norm solution error: " + max_norm_error);
    if m==9
        figure;
        plot(x,exact_soln);
        hold on;
        plot(x,u0);
        legend("exact soln", "multigrid soln");
    end
end