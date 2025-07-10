rng('default')

%Problem 5b
n=100;
sample = randn(n,1)+5;
theta_hat = exp(mean(sample));

j_mean = 0;
for a=1:100
    if a==100
        tempsample = sample(1:99);
    elseif a==1
        tempsample = sample(2:100);
    else
        tempsample = cat(1,sample(1:a-1),sample(a+1:n));
    end
    j_mean = j_mean + exp(mean(tempsample))./n;
end

bias_est = (n-1).*(j_mean-theta_hat)
valuefromparta = exp(5)*(exp(1./(2.*n))-1)
%These values are very similar but on average bias_est is larger than
%valuefromparta.


%Problem 5c
bth=0;
bthj=0;
for r=1:10000
    sample = randn(n,1)+5;
    theta_hat = exp(mean(sample));
    j_mean = 0;
    for a=1:100
        if a==100
            tempsample = sample(1:99);
        elseif a==1
            tempsample = sample(2:100);
        else
            tempsample = cat(1,sample(1:a-1),sample(a+1:n));
        end
        j_mean = j_mean + exp(mean(tempsample))./n;
    end
    thj = n.*theta_hat-(n-1).*j_mean;
    bth = bth + (theta_hat-exp(5))./10000;
    bthj = bthj + (thj-exp(5))./10000;
end

bth %B1
bthj %B2

%We can see that consistently bth is approximately equal to bias_est above,
%and that B2 is significantly smaller in magnitude.