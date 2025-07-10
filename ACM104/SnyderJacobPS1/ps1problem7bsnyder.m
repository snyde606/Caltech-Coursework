A = zeros(100, 2);
for i = 1:100
   for j = 99:100
       A(i,j-98) = j + 100*(i-1);
   end
end

b = zeros(100, 1);
for i = 1:100
    b(i, 1) = i;
end

pinv(A)*b