N = 1000;

T = 10;
delT = 0.01;
n = T/delT;

exceedct = 0;

for a = 1:N
    Zs = normrnd(0,1,n,1);
    A = sqrt(delT).*tril(ones(n,n));
    walk = A*Zs;
    maxval = max(walk);
    if maxval >= 4
       exceedct = exceedct + 1; 
    end
end

disp('Proportion Brownian motion exceeded 4:');
disp(exceedct/N);

disp('Theoretical value: ');
disp(2*(1 - normcdf(4/sqrt(10))));

disp('We can see that the estimated and theoretical values are quite close to each other.');