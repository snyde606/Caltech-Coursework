transA = transpose(A);

I = colspace(sym(A));
cI = colspace(sym(transA));
K = null(sym(A));
cK = null(sym(transA));

if isempty(K)
    dimmat = size(A);
    K = zeros(dimmat(2), 1);
end
if isempty(cK)
    dimmat = size(transA);
    cK = zeros(dimmat(2), 1);
end
if isempty(I)
    dimmat = size(A);
    I = zeros(dimmat(1), 1);
end
if isempty(cI)
    dimmat = size(transA);
    cI = zeros(dimmat(1), 1);
end

K
I
cK
cI