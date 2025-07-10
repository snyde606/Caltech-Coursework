[A,B,C,D,E,F,G] = textread("birth.txt",'%d %d %d %d %d %d %d');
[A,B,C,D,E2,F,G2] = textread("birth.txt",'%d %d %d %d %d %d %d');

E(E == 99) = [];
G(G == 9) = [];
histogram(E,'Normalization','probability')
% 15 bins appears to represent the data set fairly well. We can clearly see
% the symmetric bell shaped unimodal distribution.

mean(E) %64.0478
median(E) %64
std(E) %2.5334
iqr(E) %4
% The center of the sample is well defined because the mean and standard
% deviation are very close to each other.

figure
boxplot(E)
figure
qqplot(E)
figure
ecdf(E)

% The plots appear approximately normal with mean 64 and variance 6.

didsmoke = E2(G2 == 1);
didntsmoke = E2(G2 == 0);
didsmoke(didsmoke == 99) = [];
didntsmoke(didntsmoke == 99) = [];
figure
boxplot(didsmoke)
figure
boxplot(didntsmoke)

% The average heights of the mothers that smoke and the average heights of
% the mothers that didn't smoke appear to be approximately the same (at
% roughly 64 inches).