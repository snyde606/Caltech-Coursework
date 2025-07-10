ccrit = secant(@(c) maxeigenvalue(c,20),10,50,0.001);

disp("C_crit for n=20: ");
disp(ccrit);

cvals = [22 24 26 28 30];
maxeigs = [];
for a = 1:5
    c = cvals(a);
    maxeigs = [maxeigs maxeigenvalue(c,20)];
end
plot(maxeigs);
hold on;
fplot(@(x) 0, [1 5]);

nvals = [10 20 30 40 50 60];
maxeigs = [];
mineigs = [];
for a = 1:6
   n = nvals(a);
   maxeigs = [maxeigs maxeigenvalue(20,n)];
   mineigs = [mineigs mineigenvalue(20,n)];
end
figure;
plot(maxeigs);
figure;
plot(mineigs);