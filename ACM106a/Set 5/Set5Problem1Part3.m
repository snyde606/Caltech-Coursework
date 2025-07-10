A = [10 1 2 3 4; 1 9 -1 2 -3; 2 -1 7 3 -5; 3 2 3 12 -1; 4 -3 -5 -1 15];
b = [12 -27 14 -17 12]';
n = 0.2;
w_values = 0.2:0.2:1.8;

x0 = rand(5,1);
x_true = [1 -2 3 -2 1]';

w_norm_history = [];
for w=0.2:0.2:1.8
    [xkSOR,ctSOR,xk_historySOR,norm_historySOR] = SORSolver(A,b,x0,n,w);
    temp = zeros(max(size(w_norm_history,1),size(norm_historySOR',1)),size(w_norm_history,2)+1);
    temp(1:size(w_norm_history,1),1:size(w_norm_history,2)) = w_norm_history;
    temp(1:size(norm_historySOR',1),size(w_norm_history,2)+1) = norm_historySOR';
    w_norm_history = temp;
    
end

figure;
plot(w_norm_history);
legend("w=0.2","w=0.4","w=0.6","w=0.8","w=1.0","w=1.2","w=1.4","w=1.6","w=1.8");
title("2-Norm of residue using SOW(w)");

num_iterations=100;
iteration_counts=zeros(9,1);
for i=1:num_iterations
    x0 = rand(5,1);
    for j=1:9
        w = w_values(j);
        [xkSOR,ctSOR,xk_historySOR,norm_historySOR] = SORSolver(A,b,x0,n,w);
        iteration_counts(j) = iteration_counts(j) + ctSOR;
    end
end
iteration_counts = iteration_counts./num_iterations;

figure;
plot(w_values,iteration_counts);
title("Average number of iterations by w");