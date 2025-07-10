data = rand(100, 1);
data2 = data.^3;
mn = mean(data2);

betadata = betarnd(4,1);
betamn = betadata.^3;
betadiv = betapdf(betadata,4,1);

disp("Monte Carlo estimate: ");
disp(mn);

disp("Beta Monte Carlo estimate: ");
disp(betamn./betadiv);

