function [L,U,P] = LU_Factorization(A)
    sz = size(A);
    n = sz(1);
    P=eye(n);
    for k=1:(n-1)
        k_col = A(:,k);
        max_indices = find(k_col==max(k_col));
        max_index = max_indices(1);
        p = genPermutationMatrix(n,k,max_index);
        P=p*P;
        A = p*A;
        
        for i=(k+1):n
           A(i,k) = A(i,k)./A(k,k);
           A(i,(k+1):n) = A(i,(k+1):n) - A(i,k).*A(k,(k+1):n);
        end
    end
    L=zeros(n);
    U=zeros(n);
    for i=1:n
       U(i,i:n) = A(i,i:n);
       L(i,1:(i-1)) = A(i,1:(i-1));
       L(i,i) = 1;
    end
    P=inv(P);
end