fun = @(t,y) t.^3 - y./t;
ysoln = @(t) t.^4./5 + 1./(5.*t);
y_init = 2./5;

s=3;
hs=[0.1 0.05 0.025];
n_maxs=[10 20 40];
A = [1./2 0; -1 2];
b = [1./6 2./3 1./6];
c = [0 1./2 1];
yn0 = y_init;
k_hist = fun(1, yn0);
tn=1;
tn_history = tn;
yn_history = yn0;
critical_errors = [];
figure;
hold on;

for iter_num=1:3
    h = hs(iter_num);
    n_max = n_maxs(iter_num);
    errors_temp = [];
    yn0 = y_init;
    k_hist = fun(1, yn0);
    tn=1;
    tn_history = tn;
    yn_history = yn0;
    for n=1:n_max
        tn=tn+h;
        k_hist = fun(tn,yn0);
        for i=1:s-1
            yni = yn0 + h.*sum(A(i,1:i).*k_hist(1:i));
            k_hist = [k_hist fun(tn+h.*c(i), yni)];
        end
        yn0 = yn0 + h.*sum(b.*k_hist);
        tn_history = [tn_history tn];
        yn_history = [yn_history yn0];
        if abs(tn-1.2)<=0.0001 || abs(tn-1.4)<=0.0001 || abs(tn-1.6)<=0.0001 || abs(tn-1.8)<=0.0001 || abs(tn-2)<=0.0001
            errors_temp = [errors_temp abs(yn0-ysoln(tn))];
        end
    end
    critical_errors = [critical_errors; errors_temp];
    plot(tn_history, yn_history);
    hold on;
end

yn_exact = ysoln(tn_history);
plot(tn_history, yn_exact);
legend("h=0.1, n=10","h=0.05, n=20","h=0.025, n=40", "Exact Solution");
title("Function approximations - 2a");
hold off;

figure;
plot([1.2 1.4 1.6 1.8 2], critical_errors(1,:));
hold on;
plot([1.2 1.4 1.6 1.8 2], critical_errors(2,:));
plot([1.2 1.4 1.6 1.8 2], critical_errors(3,:));
legend("h=0.1, n=10","h=0.05, n=20","h=0.025, n=40");
title("Errors at 1.2, 1.4, 1.6, 1.8, 2.0 - 2a");