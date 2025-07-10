function u = Set1Problem3Function(n, k) 
    e = ones(n-1,1);
    alpha = 1./(k.^2);
    beta = exp(k)./(k.^2);
    A = spdiags([e,-2*e,e],[-1,0,1],n-1,n-1);
    h = 1/n;
    x = ((1:n-1)*h)';
    f = h.^2.*exp(k.*x);
    f(1) = f(1) - alpha;
    f(end) = f(end) - beta;
    u = A\f;
end