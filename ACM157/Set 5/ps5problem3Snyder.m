samples = poissrnd(1,20,10000);

vals = [];
for a=1:10000
   avg1 = mean(samples(:,a)); 
   vals = [vals abs((avg1-1).*sqrt(20./avg1))];
end

vals(vals<=1.96)=0;
vals(vals>1.96)=1;

type1errorestimate = sum(vals)./10000 %approx 0.05
