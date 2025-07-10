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
    [xk,ct] = WeightedJacobiSolver(A,f,u0,1e5,2/3);
    max_norm_error = norm(xk-exact_soln, Inf);
    disp("For n=" + n);
    disp("Jacobi iterations: " + ct);
    disp("Max-norm error: " + max_norm_error);
end