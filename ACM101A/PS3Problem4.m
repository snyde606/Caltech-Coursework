eigslist = [];
eigslist2 = [];

n = 10;
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
end

An = An./((1/(n+1)).^2);

eigslist = [eigslist eigs(An,1,'smallestabs')];
eigslist2 = [eigslist2 eigs(An,1)];

n = 20;
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
end

An = An./((1/(n+1)).^2);

eigslist = [eigslist eigs(An,1,'smallestabs')];
eigslist2 = [eigslist2 eigs(An,1)];

n = 30;
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
end

An = An./((1/(n+1)).^2);

eigslist = [eigslist eigs(An,1,'smallestabs')];
eigslist2 = [eigslist2 eigs(An,1)];

n = 40;
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
end

An = An./((1/(n+1)).^2);

eigslist = [eigslist eigs(An,1,'smallestabs')];
eigslist2 = [eigslist2 eigs(An,1)];

n = 50;
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
end

An = An./((1/(n+1)).^2);

eigslist = [eigslist eigs(An,1,'smallestabs')];
eigslist2 = [eigslist2 eigs(An,1)];

n = 60;
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
end

An = An./((1/(n+1)).^2);

eigslist = [eigslist eigs(An,1,'smallestabs')];
eigslist2 = [eigslist2 eigs(An,1)];

plot(eigslist);
hold on;
fplot(@(x) -2*pi.^2, [1 6]);
figure
plot(eigslist2);
hold on;
plot(eigslist);