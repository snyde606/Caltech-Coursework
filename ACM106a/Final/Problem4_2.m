y_init2 = [1; 0];
y_init1 = [3; 0];
h = 6.*pi./(2.^6);
error = 1;
prev_error = 1;
y_prev = [0; 0];
while error > 5e-4
    disp(error);
    [tn_history,yn_history, y_final] = RKFinal(y_init1, h);
    prev_error = error;
    error = norm(y_final-y_prev);
    y_prev = y_final;
    h = h./2;
end
convergence_order = log2(abs(prev_error/error));
figure;
disp(size(tn_history));
disp(size(yn_history));
plot(tn_history, yn_history(1, 1:size(yn_history,2)));
figure;
plot(yn_history(1, 1:size(yn_history,2)),yn_history(2,1:size(yn_history,2)));