% Method is as follows: manually change the values of h and k such that one
% of them dominates the error term. Then vary the dominant term to measure
% order of convergence. 
% For k, set h=2.*pi.*2^-12, set k=2.^-3, then
% change k to k=2.^-2. We can see that error quadruples, so it follows that
% the scheme is 2nd order accurate in k.
% Set k=2.^-11, h=2.*pi.*2.^(-3), then change h to h=2.*pi.*2.^(-2). The
% error doubles, implying that the scheme is 1st order accurate in h. This
% is surprising considering we expected the scheme to be 4th order.

f=@(x,t) sin(x-t);
exactsoln=@(x,t) sin(x-t)+t.*sin(x-t);

h_norm=@(v,h) sqrt(h.*sum(v.^2));

h  = 2.*pi.*2.^(-3);
k=2.^(-12);
mu=k./h;
t = [0:k:1];
t_len = size(t,2)-1;
x = [0:h:2.*pi];
x_len = size(x,2)-1;

dm = [ones(x_len,1).*(-1)];
d0 = [ones(x_len+1,1).*9];
dp = [ones(x_len,1).*9];
dp2 = [ones(x_len-1,1).*(-1)];
A = diag(d0)+diag(dm,-1)+diag(dp,1)+diag(dp2,2);
A(1,end)=-1;
A(end-1,1)=-1;
A(end,1:2)=[9,-1];
A=A./k;

dm = [ones(x_len,1).*(1)];
d0 = [ones(x_len+1,1).*(-27)];
dp = [ones(x_len,1).*27];
dp2 = [ones(x_len-1,1).*(-1)];
B = diag(d0)+diag(dm,-1)+diag(dp,1)+diag(dp2,2);
B(1,end) = 1;
B(end-1,1) = -1;
B(end,1:2) = [27,-1];
B=B./k;

u0 = sin(x);
u0=u0';

timer = 0;
for i=1:t_len
    AL = 1./16.*A+mu./48.*B;
    BR = 1./16.*A-mu./48.*B;
    fterm = f(x,timer+k)+f(x,timer);
    BR = BR*u0 + (k./32.*A)*(fterm');

    u0 = AL\BR;

    timer = timer + k;
end

figure;
plot(x,u0);
hold on;
exsoln=exactsoln(x,1);
plot(x,exsoln');
legend("numerical soln","exact soln");

error = h_norm(u0-exsoln',h);
disp(error);