function x = InvPowerMethod(A,x,mu,eps)
    n = size(A,1);
    x=x./norm(x);
    r=x'*A*x;
    while norm(A*x-r*x)>eps
        y=(mu.*eye(n)-A)\x;
        x=y./norm(y);
        r=x'*A*x;
    end
end