e_list = [1 0.1 0.01 0.001 0.0001];
figure;
for e_i=1:5
    e = e_list(e_i);
    a=0.5;
    N=100;
    h=1./N;
    diago = -1.*(2.*e+h).*ones(N-1,1);
    diago_b = e.*ones(N-2,1);
    diago_a = (e+h).*ones(N-2,1);
    A = diag(diago) + diag(diago_b,-1) + diag(diago_a,1);
    b = (a.*h.^2).*ones(N-1,1);

    x0 = rand(N-1,1);
    n = 0.0001;
    w = 1.2;

    [xkJ,ctJ,xk_historyJ,norm_historyJ] = JacobiSolver(A,b,x0,n);
    [xkGS,ctGS,xk_historyGS,norm_historyGS] = GaussSeidelSolver(A,b,x0,n);
    [xkSOR,ctSOR,xk_historySOR,norm_historySOR] = SORSolver(A,b,x0,n,w);

    xs = h.*(1:99);
    ys = a./(1-exp(-1./e)).*(exp(-1.*xs./e)-1)+a.*xs;

    subplot(3,2,e_i);
    plot(xs,ys);
    hold on;
    plot(xs,xkJ);
    plot(xs,xkGS);
    plot(xs,xkSOR);
    legend("Exact soln","Jacobi","Gauss-Seidel","SOR");
    title("Exact soln vs numerical solns for epsilon=" + string(e));
end