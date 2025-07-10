growth_factors=[];
for n=1:2:1000
    disp(n);
    A = normrnd(0,1./sqrt(n),n,n);
    [L,U,P]=LU_Factorization(A);
    u_max = max(max(U));
    a_max = max(max(A));
    g_fac = u_max./a_max;
    growth_factors=[growth_factors; n g_fac];
end

scatter(growth_factors(:,1),growth_factors(:,2))