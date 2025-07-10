L_stats = [];
U_stats = [];
n_bank = [];
for k=3:10
   n=2.^k;
   upper_avg_time=0;
   upper_avg_accuracy=0;
   lower_avg_time=0;
   lower_avg_accuracy=0;
   for iter = 1:10
       L = 5.*eye(n) + tril(unifrnd(0,1,n,n));
       U = 5.*eye(n) + triu(unifrnd(0,1,n,n));
       x = normrnd(0,1,n,1);
       tic;
       y_L = LowerSolver(L,x);
       L_timespent = toc;
       tic;
       y_U = UpperSolver(U,x);
       U_timespent = toc;
       acc_L = norm(x-L*y_L);
       acc_U = norm(x-U*y_U);
       
       lower_avg_time = lower_avg_time + L_timespent./10;
       upper_avg_time = upper_avg_time + U_timespent./10;
       
       lower_avg_accuracy = lower_avg_accuracy + acc_L./10;
       upper_avg_accuracy = upper_avg_accuracy + acc_U./10;
   end
   
   L_stats = [L_stats; lower_avg_time lower_avg_accuracy];
   U_stats = [U_stats; upper_avg_time upper_avg_accuracy];
   n_bank = [n_bank log2(n)];
   
end

figure
plot(n_bank, L_stats(:,1));
title('LowerSolver average runtime vs log2(n)');
xlabel('log2(n)');
ylabel('LowerSolver average runtime');

figure
plot(n_bank, L_stats(:,2));
title('LowerSolver average error vs log2(n)');
xlabel('log2(n)');
ylabel('LowerSolver average error');

figure
plot(n_bank, U_stats(:,1));
title('UpperSolver average runtime vs log2(n)');
xlabel('log2(n)');
ylabel('UpperSolver average runtime');

figure
plot(n_bank, U_stats(:,2));
title('UpperSolver average error vs log2(n)');
xlabel('log2(n)');
ylabel('UpperSolver average error');