% This FEM implementation isn't working properly; although it yields a
% solution that looks to match the general shape of the exact solution, it
% looks like it is off by some constant scaling? My best guess as to the
% issue is the construction of phi_mat and phiprime_mat (since the method
% is the same as in 1.2, where it worked, and this is the only major
% change), which represent the linear nodal functions evaluated along [0,1]
% and their derivatives respectively. This would cause the A matrix to be 
% improperly formed. However I wasn't able to fix the issues with the 
% output solution by changing the construction of phi_mat or phiprime_mat 
% so I am a bit stumped.

% The periodic condition is dealt with by ensuring that the linear nodal
% functions are periodic on [0,1].

a = @(x) 2 + sin(2.*pi.*x);
%a = @(x) 1;
f = @(x) 12.*pi.^2.*cos(2.*pi.*x)./((2+sin(2.*pi.*x)).^2);
exact_soln = @(x) cos(2.*pi.*x)./(2+sin(2.*pi.*x));

err_list = zeros(5,1);
N_list = zeros(5,1);
for p=5:9
    N = 2.^p;
    N_list(p-4) = N;

    n=2048;
    xs = ((1:n)-1)./n;
    
    phi_mat = zeros(N,2048);
    phiprime_mat = zeros(N,2048);
    per_i = n./N;
    upwards = linspace(0,1,per_i+1);
    upwards = upwards(1:per_i);
    downwards = flip(upwards);
    downwards = downwards(1:end-1);
    for i=1:N
        phi_mat(i,(i-1).*per_i+1)=1;
        if i>1
            phi_mat(i,((i-2).*per_i+1):((i-1).*per_i)) = upwards;
            phiprime_mat(i,((i-2).*per_i+2):((i-1).*per_i+1)) = ones(1,per_i);
        end
        phi_mat(i,((i-1).*per_i+2):(i.*per_i)) = downwards;
        phiprime_mat(i,((i-1).*per_i+2):(i.*per_i)) = -1.*ones(1,per_i-1);
        if i<N
            phiprime_mat(i,(i.*per_i+1)) = -1;
        end
    end
    phi_mat(1,end-per_i+1:end)=upwards;
    phi_mat(end,1:per_i-1)=downwards;
    phiprime_mat(1,end-per_i+2:end)=ones(1,per_i-1);
    phiprime_mat(end,1:per_i-1)=-1.*ones(1,per_i-1);
    phiprime_mat(1,1)=1;
    phiprime_mat = phiprime_mat./h;
    a_vec = a(xs);
    f_vec = f(xs);
    
    A=zeros(N,N);
    b=zeros(N,1); 
    for i=1:N
        for j=1:N
            do_trapz_on = a_vec.*phiprime_mat(i,:).*phiprime_mat(j,:);
            %disp(size(do_trapz_on));
            %A(i,j) = 1./n.*sum(do_trapz_on);
            A(i,j) = sum(do_trapz_on);
        end
        do_trapz_on = f_vec.*phi_mat(i,:);
        b(i) = 1./n.*sum(do_trapz_on);
    end
    
    A=A./n;
    
    %ensuring that integral from 0 to 1 of soln is 0
    %A(end,:) = ones(1,N);
    %b(end) = 0;

    soln = A\b;
    
    mysoln=sum(soln.*phi_mat);
    xtsoln=exact_soln(xs);
    figure
    plot(mysoln)
    hold on
    plot(xtsoln)
    
    errs = abs(sum(soln.*phi_mat)-exact_soln(xs));
    errs = errs.^2;
    err = sum(errs)./n;
    err = sqrt(err);
    err_list(p-4) = err;
end

figure;
plot(N_list,err_list);