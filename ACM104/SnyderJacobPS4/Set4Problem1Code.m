A = [1, 2, -1; 0, -2, 3; 1, 5, -1; -3, 1, 1];
b = transpose([0, 5, 6, 8]);
x = inv(A'*A)*A'*b;
x

LSE = sqrt(norm(b)^2 - b'*A*inv(A'*A)*A'*b);
LSE