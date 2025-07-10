A = [10 1 2 3 4; 1 9 -1 2 -3; 2 -1 7 3 -5; 3 2 3 12 -1; 4 -3 -5 -1 15];
b = [12 -27 14 -17 12]';
n = 0.001;
w = 1.4;

x0 = rand(5,1);
x_true = [1 -2 3 -2 1]';

[xkJ,ctJ,xk_historyJ,norm_historyJ] = JacobiSolver(A,b,x0,n);
[xkGS,ctGS,xk_historyGS,norm_historyGS] = GaussSeidelSolver(A,b,x0,n);
[xkSOR,ctSOR,xk_historySOR,norm_historySOR] = SORSolver(A,b,x0,n,w);

xk_errorJ = bsxfun(@plus, xk_historyJ, -1.*x_true);
xk_errorGS = bsxfun(@plus, xk_historyGS, -1.*x_true);
xk_errorSOR = bsxfun(@plus, xk_historySOR, -1.*x_true);
xk_errorJ = vecnorm(xk_errorJ);
xk_errorGS = vecnorm(xk_errorGS);
xk_errorSOR = vecnorm(xk_errorSOR);

figure;
subplot(1,2,1);
plot(norm_historyJ);
hold on;
plot(norm_historyGS);
plot(norm_historySOR);
legend("Jacobi","Gauss-Seidel","SOR");
title("2-Norm of residue by iteration using different iterative methods");
hold off;

subplot(1,2,2);
plot(xk_errorJ);
hold on;
plot(xk_errorGS);
plot(xk_errorSOR);
legend("Jacobi","Gauss-Seidel","SOR");
title("Error by iteration using different iterative methods");