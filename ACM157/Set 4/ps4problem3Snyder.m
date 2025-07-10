trials = 10000;

mse = 0;
for a=1:trials
   sample = unifrnd(1,3,10,1);
   diff = ((max(sample)+min(sample))./2-2)^2;
   mse = mse + diff./trials;
end

mse

%The value we get for mse using this monte carlo simulation is very close
%to the value of mse we got analytically, 1/30 ~= 0.0333