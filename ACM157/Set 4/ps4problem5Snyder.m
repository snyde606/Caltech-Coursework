sample = unifrnd(0,1,50,1);
bootstat = bootstrp(10000,@max,sample);
parastat = [];
for i=1:10000
   sample2 = unifrnd(0,max(sample),50,1);
   parastat = [parastat max(sample2)];
end

histogram(bootstat,'Normalization','pdf')
%histogram(bootstat)
hold on
%histogram(parastat)
histogram(parastat,'Normalization','pdf')
fplot(@(x) 50.*(x.^49),[0.8 1],'r')

%We observe that our calculated pdf fits the parametric bootstrap well but
%does not fit the non-parametric bootstrap very well.