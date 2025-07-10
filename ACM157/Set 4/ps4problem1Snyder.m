[A,B,C,D,magnitudes,numstations] = textread("fiji.txt",'%f %f %f %f %f %f');

scatter(magnitudes,numstations)
correlation = corr(magnitudes,numstations);

bootstat = bootstrp(1000,@corr,magnitudes,numstations);
sterr_theta = std(bootstat); %STANDARD ERROR

histogram(bootstat)
hold on;
line([correlation, correlation], ylim, 'LineWidth', 2, 'Color', 'r');

pd = fitdist(bootstat,'Normal');
ci = paramci(pd);
normal_theta_ci = norminv([0.025 0.975],mean(bootstat),std(bootstat)) %NORMAL CONFIDENCE INTERVAL

piv_ci = bootci(1000,@corr,magnitudes,numstations); %PIVOT CONFIDENCE INTERVAL