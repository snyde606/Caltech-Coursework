a = 1;
n = 3;
xs = linspace(-a,a,n);
ys = cos(xs)./cosh(xs);
[p,S] = polyfit(xs,ys,n-1);
f = @(xes) polyval(p,xes);
subplot(4,2,1)
plot(xs,ys,'bo')
hold on
ezplot(f)
ezplot('cos(x)/cosh(x)')
title('a=1, n=3');
xlim([-5 5]);
ylim([-1 5]);
hold off

a = 5;
n = 3;
xs = linspace(-a,a,n);
ys = cos(xs)./cosh(xs);
[p,S] = polyfit(xs,ys,n-1);
f = @(xes) polyval(p,xes);
subplot(4,2,2)
plot(xs,ys,'bo')
hold on
ezplot(f)
ezplot('cos(x)/cosh(x)')
title('a=5, n=3');
xlim([-5 5]);
ylim([-1 5]);
hold off

a = 1;
n = 5;
xs = linspace(-a,a,n);
ys = cos(xs)./cosh(xs);
[p,S] = polyfit(xs,ys,n-1);
f = @(xes) polyval(p,xes);
subplot(4,2,3)
plot(xs,ys,'bo')
hold on
ezplot(f)
ezplot('cos(x)/cosh(x)')
title('a=1, n=5');
xlim([-5 5]);
ylim([-1 5]);
hold off

a = 5;
n = 5;
xs = linspace(-a,a,n);
ys = cos(xs)./cosh(xs);
[p,S] = polyfit(xs,ys,n-1);
f = @(xes) polyval(p,xes);
subplot(4,2,4)
plot(xs,ys,'bo')
hold on
ezplot(f)
ezplot('cos(x)/cosh(x)')
title('a=5, n=5');
xlim([-5 5]);
ylim([-1 5]);
hold off

a = 1;
n = 10;
xs = linspace(-a,a,n);
ys = cos(xs)./cosh(xs);
[p,S] = polyfit(xs,ys,n-1);
f = @(xes) polyval(p,xes);
subplot(4,2,5)
plot(xs,ys,'bo')
hold on
ezplot(f)
ezplot('cos(x)/cosh(x)')
title('a=1, n=10');
xlim([-5 5]);
ylim([-1 5]);
hold off

a = 5;
n = 10;
xs = linspace(-a,a,n);
ys = cos(xs)./cosh(xs);
[p,S] = polyfit(xs,ys,n-1);
f = @(xes) polyval(p,xes);
subplot(4,2,6)
plot(xs,ys,'bo')
hold on
ezplot(f)
ezplot('cos(x)/cosh(x)')
title('a=5, n=10');
xlim([-5 5]);
ylim([-1 5]);
hold off

a = 1;
n = 15;
xs = linspace(-a,a,n);
ys = cos(xs)./cosh(xs);
[p,S] = polyfit(xs,ys,n-1);
f = @(xes) polyval(p,xes);
subplot(4,2,7)
plot(xs,ys,'bo')
hold on
ezplot(f)
ezplot('cos(x)/cosh(x)')
title('a=1, n=15');
xlim([-5 5]);
ylim([-1 5]);
hold off

a = 5;
n = 15;
xs = linspace(-a,a,n);
ys = cos(xs)./cosh(xs);
[p,S] = polyfit(xs,ys,n-1);
f = @(xes) polyval(p,xes);
subplot(4,2,8)
plot(xs,ys,'bo')
hold on
ezplot(f)
ezplot('cos(x)/cosh(x)')
title('a=5, n=15');
xlim([-5 5]);
ylim([-1 5]);
hold off