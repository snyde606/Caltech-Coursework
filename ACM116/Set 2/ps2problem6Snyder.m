Ydata10 = [];
Ydata100 = [];
Ydata1000 = [];
Ydata10000 = [];

for a = 1:1000
    data = rand(10,1);
    data(data>0.5) = 1;
    data(data<=0.5) = -1;
    Ydata10 = [Ydata10 sqrt(10).*mean(data)];
    
    data = rand(100,1);
    data(data>0.5) = 1;
    data(data<=0.5) = -1;
    Ydata100 = [Ydata100 sqrt(100).*mean(data)];
    
    data = rand(1000,1);
    data(data>0.5) = 1;
    data(data<=0.5) = -1;
    Ydata1000 = [Ydata1000 sqrt(1000).*mean(data)];
    
    data = rand(10000,1);
    data(data>0.5) = 1;
    data(data<=0.5) = -1;
    Ydata10000 = [Ydata10000 sqrt(10000).*mean(data)];
end

fplot(@(x) normcdf(x), [-1,1]);
hold on;
ecdf(Ydata10);
ecdf(Ydata100);
ecdf(Ydata1000);
ecdf(Ydata10000);