processed = [];
for i = 1:500
    processed = [processed, A(:,i)./sum(A(:,i))];
end
A = processed;

alpha = [0.1,0.15,0.2];
n = 500;

S = ones(n);

Ltilde1 = (1-alpha(1)).*A + alpha(1).*S./n;
Ltilde2 = (1-alpha(2)).*A + alpha(2).*S./n;
Ltilde3 = (1-alpha(3)).*A + alpha(3).*S./n;

A = Ltilde1;
ps6problem1Snyder
[B1,I1] = maxk(xk1,10);

A = Ltilde2;
ps6problem1Snyder
[B2,I2] = maxk(xk1,10);

A = Ltilde3;
ps6problem1Snyder
[B3,I3] = maxk(xk1,10);

disp('Top 10 airport indices for alpha=0.1: ')
disp(I1);

disp('Top 10 airport indices for alpha=0.15: ')
disp(I2);

disp('Top 10 airport indices for alpha=0.2: ')
disp(I3);