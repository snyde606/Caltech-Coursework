n=200;
h=1./n;
A = 1./(h.^2).*(diag(2.*ones(n-1,1))-diag(ones(n-2,1),-1)-diag(ones(n-2,1),1));
hess_A = HessenbergReduction(A);

B = TridiagonalQRGivens(A);
%C = TridiagonalQRGivensShift(A); broken?

eigB = sort(eig(B));
%eigC = sort(eig(C));

top10=eigB(1:10);

eigvects = [];
for i=1:10
    mu=top10(i);
    x=ones(n-1,1);
    eigvect = InvPowerMethod(A,x,mu,0.001);
    eigvects = [eigvects eigvect];
end

[A_eigvectors,A_eigvalues] = eig(A);

%Looking at the eigenpairs from the Givens QR iteration/Inverse Power
%Method vs those of MATLAB's eig(), they seem to be quite different -
%unclear if this is because this discretization is a poor approximation or
%there is just something broken in my QR iteration code.