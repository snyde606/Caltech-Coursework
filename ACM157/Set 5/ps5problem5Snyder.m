%part A
data1 = [0.225, 0.262, 0.217, 0.240, 0.230, 0.229, 0.235, 0.217];
data2 = [0.209, 0.205, 0.196, 0.210, 0.202, 0.207, 0.224, 0.223, 0.220, 0.201];

mean1 = mean(data1);
mean2 = mean(data2);

var1 = var(data1);
var2 = var(data2);

combstd = sqrt(var1./8+var2./10);

zscore = abs((mean1-mean2)./combstd); %value of 3.7036
pval = 2*(1-normcdf(zscore)); %pvalue of 2.126*10^(-4)
%We therefore conclude that these are
%not the same true mean and thus the Snodgrass essays were not written by
%Twain.

%part B
obsdiff = abs(mean(data1)-mean(data2));
combineddata = [data1 data2];

diffs = [];
for a=1:10000
    gendata1 = randsample(combineddata, 8);
    gendata2 = combineddata(~ismember(combineddata,gendata1));
    if length(gendata2)==9
       gendata2 = [gendata2 0.2170]; 
    end
    calc = abs(mean(gendata1)-mean(gendata2));
    diffs = [diffs calc];
end

diffs(diffs<obsdiff)=0;
diffs(diffs>obsdiff)=1;
sum(diffs)./10000 %estimated p-value around 4e-04
% We therefore conclude that these are no the same true mean and thus the
% Snodgrass essays were not written by Twain.
