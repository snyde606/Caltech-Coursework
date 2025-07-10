expvals=[];

for k=1:1000
  data = binornd(100, 0.3);
  mn = mean(data);
  expvals = [expvals mn];
end

disp(mean(expvals))

plot(expvals, '.');
hold on;
line([0, 1000],[30,30]);
