n = size(A);
n = n(1);

xk1 = rand(n,1);
xk0 = rand(n,1);

while norm(xk1-xk0) > 0.000000000001
    xk0 = xk1;
    xk1 = A*xk1;
    xk1 = xk1/norm(xk1);
end

disp('Dominant eigenvector: ');
disp(xk1);

b = A*xk1;
eigenvalue = b(1)./xk1(1);

disp('Dominant eigenvalue: ');
disp(eigenvalue);