n=100;
rng(2021);
x0 = randn(n, 1);
K=100;
eps_list = [1e-3 1e-5, 1e-7, 1e-9];
b=ones(n,1);
b(1) = 1.5;
A = diag(4.*ones(n,1)) + diag(-1.*ones(n-1,1),-1) + diag(-1.*ones(n-2,1),-2);
A = A + diag(-1.*ones(n-1,1),1) + diag(-1.*ones(n-2,1),2);
L = diag(ones(n,1)) + diag(-1.*ones(n-1,1),-1);
M = L*L';

CG_list = [];
PCG_list = [];
GSS_list = [];
JS_list = [];
SOR_list = [];
for index=1:4
    eps = eps_list(index);
    [x,ct] = CG(A, b, x0, eps, K);
    CG_list = [CG_list ct];
    [x,ct] = PCG(A, b, M, x0, eps, K);
    PCG_list = [PCG_list ct];
    [xk,ct,xk_history,norm_history] = JacobiSolver(A,b,x0,eps);
    JS_list = [JS_list ct];
    [xk,ct,xk_history,norm_history] = GaussSeidelSolver(A,b,x0,eps);
    GSS_list = [GSS_list ct];
    SOR_list_2 = [];
    for w=0.1:0.1:1.9
        [xk,ct,xk_history,norm_history] = SORSolver(A,b,x0,eps,w);
        SOR_list_2 = [SOR_list_2 ct];
    end
    SOR_list = [SOR_list min(SOR_list_2)];
end

figure;
plot(log(CG_list));
hold on;
plot(log(PCG_list));
plot(log(GSS_list));
plot(log(JS_list));
plot(log(SOR_list));
legend("CG ln of number of iterations", "PCG ln of number of iterations","GSS ln of number of iterations","JS ln of number of iterations","SOR ln of number of iterations");

% Problem 2c end: NOTE THAT THE PLOT IS LN(# OF ITERATIONS. We can see that
% the number of iterations required for the Jacobi solver and GSS solver is higher by
% orders of magnitude than the number of iterations for SOR, CG, and PCG.
% PCG is the best in terms of number of iterations, with CG second.