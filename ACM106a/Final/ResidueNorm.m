function n = ResidueNorm(A,b,xk)
    rk = b-A*xk;
    n = norm(rk);
end