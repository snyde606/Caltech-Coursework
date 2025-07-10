grthanct = 0;
for a = 1:10000
    data = poissrnd(1,100,1);
    datasum = sum(data);
    if datasum >= 120
        grthanct = grthanct + 1;
    end
end
m
markovbound = 100./120;

cltval = (12./10 - 1)./(1./10);
cltprob = 1 - normcdf(cltval,0,1);
rlprob = grthanct./10000;

disp("Markov Bound: ");
disp(markovbound);

disp("CLT estimate: ");
disp(cltprob);

disp("Estimated probability: ");
disp(rlprob);