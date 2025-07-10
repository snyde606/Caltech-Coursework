N=32;
M=32;
intEnd = pi./4;
b = pi; %ensure b-periodicity
xj = linspace(0,intEnd,N);
yj = exp(cos(xj).^2);

%construct A
A = zeros(N,2.*M+1);
for i=1:N
    for j=1:2.*M+1
       if j>M+1
          A(i,j) = sin((j-M-1).*2.*pi.*xj(i)/b);
       elseif j==1
          A(i,j) = 0.5;
       else
          A(i,j) = cos((j-1).*2.*pi.*xj(i)/b);
       end
    end
end

[U,S,V] = svd(A);
s = diag(S);
tol = max(size(A)) * eps(norm(s,inf));
r1 = sum(s > tol)+1;
V(:,r1:end) = [];
U(:,r1:end) = [];
s(r1:end) = [];
s = 1./s(:);
s = diag(s);
c = (V*s)*U'*yj';

fp = A*c;
figure
plot(fp)
figure
plot(yj)