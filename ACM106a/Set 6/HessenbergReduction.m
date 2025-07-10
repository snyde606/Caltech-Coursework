function A = HessenbergReduction(A)
    n = size(A,1);
    for i=1:(n-2)
        u_i = House(A(i+1:n,i));
        P_i = eye(n-i)-2.*u_i*u_i';
        A(i+1:n,i:n) = P_i*A(i+1:n,i:n);
        A(1:n,i+1:n) = A(1:n,i+1:n)*P_i;
    end
end