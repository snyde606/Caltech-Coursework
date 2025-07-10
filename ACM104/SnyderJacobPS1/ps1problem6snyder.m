vec = logspace(2, 4, 25);
times = zeros(25, 1);
for i = 1 : 25
    A = normrnd(0,1,cast(vec(i), 'uint16')) ;
    f = @() det(A);
    times(i) = timeit(f);
end

loglog(vec, times)