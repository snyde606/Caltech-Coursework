beta_error_table = zeros(10,7);
ypsilon_error_table = zeros(10,8);

for k = 1:10
    last_error = -1;
    for m = 3:10
        n = 2.^m;
        h = 1/n;
        x = ((1:n-1)*h)';
        u_approx = Set1Problem3Function(n,k);
        u_exact = true_u(x,k);
        u_error = u_approx-u_exact;
        error2norm = norm(u_error);
        if last_error ~= -1
            beta_error = log2(abs(error2norm./last_error));
            beta_error_table(k,m-3) = beta_error;
        end
        ypsilon_error_table(k,m-2) = error2norm./(h.^2.*f_dub_prime_norm(x,k));
        last_error = error2norm;
    end
end

disp(beta_error_table);
disp(ypsilon_error_table);

function a = true_u(x,k)
    a = 1./(k.^2).*exp(k.*x);
end

function a = f_dub_prime_norm(x,k)
    a = norm(k.^2.*exp(k.*x));
end