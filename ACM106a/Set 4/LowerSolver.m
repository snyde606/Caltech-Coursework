function y = LowerSolver(L,x)
    sz = size(L);
    n = sz(1);
    y = x(1)./L(1,1);
    for i=2:n
        y_temp = x(i)/L(i,i);
        for j=1:i-1
            y_temp = y_temp - L(i,j).*y(j)./L(i,i);
        end
        y = [y; y_temp];
    end
end