data = rand(10000,1);
data2 = icdf('Exponential',data,5);

histogram(data2,'Normalization','pdf');
hold on;
fplot(@(x) exppdf(x,5), [0 50]);