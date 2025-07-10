function [xk,ct] = PCG(A, b, M, x0, eps, K)
    xk = x0;
    rk = b-A*xk;
    wk = inv(M)*rk;
    pk = wk;
    rhok = rk'*wk;
    k=0;
    ct = 0;
    while sqrt(rk'*rk)>eps && k<=K
        ct = ct + 1;
        zk = A*pk;
        alphak = rhok/(pk'*zk);
        xk = xk + alphak*pk;
        rk = rk - alphak*zk;
        wk = inv(M)*rk;
        rhok1 = rk'*wk;
        betak = rhok1/rhok;
        rhok = rhok1;
        pk = wk + betak*pk;
        k = k + 1;
    end
end