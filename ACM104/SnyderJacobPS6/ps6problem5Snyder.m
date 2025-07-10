A = zeros(50);
A(1:20,1:20) = 1;
A(21:50,21:50) = 1;
A(21,1) = 1;
A(22,2) = 1;
A(23,3) = 1;
A(1,21) = 1;
A(2,22) = 1;
A(3,23) = 1;
for i = 1:50
   A(i,i) = 0; 
end

D = zeros(50);
for i = 1:50
    D(i,i) = sum(A(:,i));
end

L = D-A;
[eivec,eival0] = eig(L);
eival = [];
for i = 1:50
    eival = [eival, eival0(i,i)];
end
[B,I] = mink(eival,2);

v2 = eivec(:,I(2));

Splus = [];
[B,I] = maxk(v2,20);
for i = 1:50
    if ismember(i,I)
        Splus = [Splus,1];
    else
        Splus = [Splus,-1];
    end
end
Sminus = (-1).*Splus;

Rplus = 0.25.*(Splus*L*Splus');
Rminus = 0.25.*(Sminus*L*Sminus');

disp(Rplus);
disp(Rminus);
spy(A);
figure('Name','Graph of A');
plot(graph(A),'NodeLabel',{});