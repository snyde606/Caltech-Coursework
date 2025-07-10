R = linspace(2,30,29);

alphatops = (R+log(R)+pi/2).*pi.*R;
alphabots = R.^3.-1;
alphas = alphatops./alphabots;

betafuntop = @(x) 1i.*(2:30).^2.*exp(2i.*x)+1i.*(2:30).*exp(1i.*x).*log((2:30).*exp(1i.*x));
betafunfront = @(x) 1i.*(2:30).*exp(1i.*x);
betafunbot = @(x) (2:30).^3.*exp(3i.*x)+1;
betafun = @(x) betafuntop(x)./betafunbot(x);

plot(R, alphas);
hold on;
plot(R, abs(integral(betafun, -pi/2, pi/2, 'ArrayValued', true)));
