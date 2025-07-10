ab=0;
a=0;
b=0;

for k=1:1000
  data = unidrnd(6);
  if data<5
      b=b+1;
  end
  if data==2 || data==4
      a=a+1;
      ab=ab+1;
  elseif data==6
      a=a+1;
  end
end

atb=(a./1000).*(b./1000);

disp('P(AB)');
disp(ab./1000);
disp('P(A)P(B)');
disp(atb);
