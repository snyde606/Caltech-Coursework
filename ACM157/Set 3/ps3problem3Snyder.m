[A,B,C,D,magnitudes,F] = textread("fiji.txt",'%f %f %f %f %f %f');

%Problem 3a
[f,x,f1,f2] = ecdf(magnitudes);
ecdf(magnitudes,'Bounds','on')
hold on

epsilon = sqrt(1./2000.*log(2./(0.05)));

%Problem 3b
figure
plot(x,f)
hold on
ecdf(magnitudes)
fbig = f+epsilon;
fbig(fbig>1)=1;
fbig(fbig<0)=0;
fsmall = f-epsilon;
fsmall(fsmall>1)=1;
fsmall(fsmall<0)=0;
plot(x,fbig)
plot(x,fsmall)