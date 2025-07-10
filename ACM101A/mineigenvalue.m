function y = mineigenvalue(c,n)

n2 = n.*n;
An = zeros(n2,n2);

for a = 1:n2
    j = floor((a-1)./n) + 1;
    i = mod(a-1,n) + 1;
    if i ~= n
        An(a,(j-1).*n + i + 1) = 1;
    end
    if i ~= 1
        An(a,(j-1).*n + i - 1) = 1;
    end
    if j ~= n
        An(a,(j).*n + i) = 1;
    end
    if j ~= 1
        An(a,(j-2).*n + i) = 1;
    end
    An(a,(j-1).*n + i) = -4;
    
    if i >= 0.25.*n && i <= 0.75.*n && j>=0.25.*n && j<=0.75.*n
        An(a,(j-1).*n + i) = -4 + c.*((1/(n+1)).^2);
    end
    
end

An = An./((1/(n+1)).^2);

y = eigs(An,1,'smallestreal');

end