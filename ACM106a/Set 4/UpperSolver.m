function y = UpperSolver(U,x)
    sz = size(U);
    n = sz(1);
    y = x(n)./U(n,n);
    for i=1:n-1
        y_sz = size(y);
        y_sz = y_sz(1);
        y_temp = x(n-i)/U(n-i,n-i);
        for j=0:i-1
            y_temp = y_temp - U(n-i,n-j).*y(y_sz-j)./U(n-i,n-i);
        end
        y = [y_temp; y];
    end
end