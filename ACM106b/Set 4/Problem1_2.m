% The errors decay VERY quickly with N. We can see that the error becomes
% less than machine precision after N=60. The order of convergence is hard
% to determine since error quickly becomes less than machine precision, but
% we can see that error is decreasing by a factor of roughly 1e6 from N=20
% to N=40.

a = @(x) 2 + sin(2.*pi.*x);
f = @(x) 12.*pi.^2.*cos(2.*pi.*x)./((2+sin(2.*pi.*x)).^2);
exact_soln = @(x) cos(2.*pi.*x)./(2+sin(2.*pi.*x));

err_list = zeros(10,1);
N_list = zeros(10,1);
for p=1:10
    N = 20.*p;
    N_list(p) = N;
    phi1 = @(x) transpose(sin(2.*pi.*(1:N/2).*x));
    phi1prime = @(x) transpose(cos(2.*pi.*(1:N/2).*x).*(2.*pi.*(1:N/2)));
    phi2 = @(x) transpose(cos(2.*pi.*(1:N/2).*x));
    phi2prime = @(x) transpose(-1.*sin(2.*pi.*(1:N/2).*x).*(2.*pi.*(1:N/2)));
    phi = @(x) [phi1(x'); phi2(x')];
    phiprime = @(x) [phi1prime(x'); phi2prime(x')];

    n=512;
    xs = ((1:n)-1)./n;
    phi_mat = phi(xs);
    phiprime_mat = phiprime(xs);
    a_vec = a(xs);
    f_vec = f(xs);

    A=zeros(N,N);
    b=zeros(N,1);
    for i=1:N
        for j=1:N
            do_trapz_on = a_vec.*phiprime_mat(i,:).*phiprime_mat(j,:);
            %disp(size(do_trapz_on));
            A(i,j) = 1./n.*sum(do_trapz_on);
        end
        do_trapz_on = f_vec.*phi_mat(i,:);
        b(i) = 1./n.*sum(do_trapz_on);
    end

    soln = A\b;
    errs = abs(sum(soln.*phi(xs))-exact_soln(xs));
    errs = errs.^2;
    err = sum(errs)./n;
    err = sqrt(err);
    err_list(p) = err;
end

figure;
plot(N_list,log10(err_list));
title("N vs log10(error)");