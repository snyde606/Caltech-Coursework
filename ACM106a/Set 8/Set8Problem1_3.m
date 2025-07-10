fun = @(x) exp(sin(x)./sqrt(2));
exact_val = integral(fun,0,2.*pi)./(2.*pi);

% trapezoidal approximation
k=-1;
h_history = [];
error_history = [];
while true
    k = k + 1;
    h = 2.*pi./(2.^(k+1));
    h_history = [h_history h];
    x_is = 0:h:(2.*pi);
    trap_estimate = h./(4.*pi).*(fun(x_is(1))+2.*sum(fun(x_is(:,2:size(x_is,2)-1)))+fun(x_is(end)));
    error = trap_estimate - exact_val;
    error_history = [error_history error];
    if error == 0
        break;
    end
end

plot(error_history);