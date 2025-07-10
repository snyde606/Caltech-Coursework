N = 50;
gamma = 1;
xs = linspace(0,1,N);
joon = besselzero(0,N);

approx = zeros(1,N);
for a=1:N
    an = 2.*gamma.*besselj(1,joon(a).*gamma)./(joon(a).*besselj(1,joon(a)).^2);
    approx = approx + an.*besselj(0,joon(a).*xs);
end

actual = zeros(1,N);
actual(xs<=gamma) = 1;
actual(xs>gamma) = 0;

plot(approx);
hold on;
plot(actual);

overshoot_at_gamma = abs(approx(floor(gamma.*N)-1)-1) %approx 8.95 percent, as expected
overshoot_at_0 = abs(approx(1)-1)