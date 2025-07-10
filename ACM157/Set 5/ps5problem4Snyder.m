% We will use the permutation test, with alpha=0.05
data1 = [7.58 8.52 8.01 7.99 7.93 7.89 7.85 7.82 7.80];
data2 = [7.85 7.73 8.53 7.40 7.35 7.30 7.27 7.27 7.23];

obsdiff = abs(mean(data1)-mean(data2));
combineddata = [data1 data2];

diffs = [];
for a=1:10000
    indy = randperm(18);
    gendata1 = combineddata(indy(1:9));
    gendata2 = combineddata(indy(10:18));
    calc = abs(mean(gendata1)-mean(gendata2));
    diffs = [diffs calc];
end

diffs(diffs<obsdiff)=0;
diffs(diffs>obsdiff)=1;
sum(diffs)./10000 %approx 0.032

%Therefore we conclude that the true mean pH values differ for the 2
%locations.