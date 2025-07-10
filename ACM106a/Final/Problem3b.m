% Problem 3b
% We can use Givens QR decomposition for Hessenberg matrices (with
% shifting) since A is a Hessenberg matrix. Essentially, the decomposition
% of A_k into QR can be done in just n-1 Givens rotations (as described on
% page 93-94 of the Lecture 5 notes). This makes QR method with shifting
% particularly easy for this form of matrix. From the resulting similar
% matrix we can extract the eigenvalues, which are equivalent to the roots
% of p(x) as discussed in part (a).

% Problem 3c_i
p = @(x) x.^3 + x.^2 - 5.*x + 3;
A = [0 0 -3; 1 0 5; 0 1 -1];
A_2 = HessenbergQR(A);
roots = diag(A_2);
figure;
plot(abs(p(roots)));

% Problem 3c_ii
p = @(x) x.^8 + 100.*x.^7 + 208.*x.^6 + 10890.*x.^5 + 9802.*x.^4 + 79108.*x.^3 - 99902.*x.^2 + 790.*x - 1000;
A = diag(ones(7,1),-1);
A(1:8,8) = [1000 -790 99902 -79108 -9802 -10890 -208 -100];
A_2 = HessenbergQR(A);
roots = diag(A_2);
figure;
plot(abs(p(roots)));

% Problem 3c_iii
p = @(x) x.^41 + x.^3 + 1;
A = diag(ones(40,1),-1);
A(1,41) = -1;
A(4,41) = -1;
A_2 = HessenbergQR(A);
roots = diag(A_2);
figure;
plot(abs(p(roots)));