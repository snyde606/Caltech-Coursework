function y = secant(f,x2,x1,maxerr)

xn = (x2*f(x1) - x1*f(x2))/(f(x1) - f(x2));

while abs(f(xn)) > maxerr
    x2 = x1;
    x1 = xn;
    xn = (x2*f(x1) - x1*f(x2))/(f(x1) - f(x2));
end

y = xn;