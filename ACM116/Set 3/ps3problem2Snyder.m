infct = 0;
xsum = 0;

for a = 1:10000
    data = betarnd(2,6);
    data2 = data.^2;
    data3 = rand();
    if data3 <= data2
        infct = infct + 1;
        xsum = xsum + data;
    end
end

expxinf = xsum./infct;

disp("Expected value of X given influenza: ");
disp(expxinf);