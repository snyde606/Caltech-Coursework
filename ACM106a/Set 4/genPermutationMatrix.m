function B = genPermutationMatrix(n,i,j)
    B = eye(n);
    a = 1:n;
    a(i) = j;
    a(j) = i;
    B = B(a,:);
end