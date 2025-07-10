a = 5;
n = 3;
xs = linspace(-a,a,n);
ys = cos(xs)./cosh(xs);
f = @(xes) pofn(xes,n,a);
[p,S] = polyfit(xs,ys,n-1);
f2 = @(xes) polyval(p,xes);
subplot(2,2,1)
plot(xs,ys,'bo')
hold on
fplot(f)
fplot(f2)
ezplot('cos(x)/cosh(x)')
title('a=5, n=3');
xlim([-5 5]);
ylim([-1 5]);
legend('Points used','Approximating polynomials','Interpolating polynomials','cos(x)/cosh(x)')
hold off

a = 5;
n = 5;
xs = linspace(-a,a,n);
ys = cos(xs)./cosh(xs);
f = @(xes) pofn(xes,n,a);
[p,S] = polyfit(xs,ys,n-1);
f2 = @(xes) polyval(p,xes);
subplot(2,2,2)
plot(xs,ys,'bo')
hold on
fplot(f)
fplot(f2)
ezplot('cos(x)/cosh(x)')
title('a=5, n=5');
xlim([-5 5]);
ylim([-1 5]);
legend('Points used','Approximating polynomials','Interpolating polynomials','cos(x)/cosh(x)')
hold off

a = 5;
n = 10;
xs = linspace(-a,a,n);
ys = cos(xs)./cosh(xs);
f = @(xes) pofn(xes,n,a);
[p,S] = polyfit(xs,ys,n-1);
f2 = @(xes) polyval(p,xes);
subplot(2,2,3)
plot(xs,ys,'bo')
hold on
fplot(f)
fplot(f2)
ezplot('cos(x)/cosh(x)')
title('a=5, n=10');
xlim([-5 5]);
ylim([-1 5]);
legend('Points used','Approximating polynomials','Interpolating polynomials','cos(x)/cosh(x)')
hold off

a = 5;
n = 15;
xs = linspace(-a,a,n);
ys = cos(xs)./cosh(xs);
f = @(xes) pofn(xes,n,a);
[p,S] = polyfit(xs,ys,n-1);
f2 = @(xes) polyval(p,xes);
subplot(2,2,4)
plot(xs,ys,'bo')
hold on
fplot(f)
fplot(f2)
ezplot('cos(x)/cosh(x)')
title('a=5, n=15');
xlim([-5 5]);
ylim([-1 5]);
legend('Points used','Approximating polynomials','Interpolating polynomials','cos(x)/cosh(x)')
hold off

function p = pofn(xval,n,a)
    tot = 0;
    for i = 0:(n-1)
       fun = @(x) cos(x*a)./cosh(x*a).*legendreP(i,x);
       alpha = ((2*i+1)./2).*integral(fun,-1,1);
       qbar = legendreP(i,xval/a);
       tot = tot + alpha.*qbar;
    end
    p = tot;
end