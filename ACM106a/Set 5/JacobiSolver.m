function [xk,ct,xk_history,norm_history] = JacobiSolver(A,b,x0,n)
    ct=0;
    norm_history = [];
    xk_history = [x0];
    D = diag(diag(A));
    L = -1.*tril(A,-1);
    U = -1.*triu(A,1);
    RJ = D\(L+U);
    gJ = D\b;
    xk = x0;
    while true
        ct = ct+1;
        xk = RJ*xk+gJ;
        xk_history = [xk_history xk];
        norm_check = ResidueNorm(A,b,xk);
        norm_history = [norm_history norm_check];
        if norm_check <= n
            break;
        end
    end
end