function [xk,ct] = WeightedJacobiSolver(A,b,x0,num_iterations,w)
    ct=0;
    D = diag(diag(A));
    L = -1.*tril(A,-1);
    U = -1.*triu(A,1);
    RJ = D\(L+U);
    gJ = D\b;
    xk = x0;
    xkprev = x0;
    while true
        ct = ct+1;
        xk = w.*(RJ*xk+gJ)+(1-w).*xk;
        if ct >= num_iterations
            break;
        end
        if abs(xk./xkprev-1) < 1e-5
            break;
        end
        xkprev = xk;
    end
end