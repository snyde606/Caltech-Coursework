function [xk,ct] = CG(A, b, x0, eps, K)
    xk = x0;
    rk = b-A*xk;
    pk = rk;
    rhok = rk'*rk;
    k=0;
    ct = 0;
    while sqrt(rhok)>eps && k<=K
        ct = ct+1;
        zk = A*pk;
        alphak = rhok/(pk'*zk);
        xk = xk + alphak*pk;
        rk = rk - alphak*zk;
        rhok1 = rk'*rk;
        betak = rhok1/rhok;
        rhok = rhok1;
        pk = rk + betak*pk;
        k = k + 1;
    end
end