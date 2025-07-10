n=64;
ks = [3 27 37 61];
for k_index=1:4
    k = ks(k_index);
    w = sin((1:n-1).*k.*pi./n)';
    res_w = restrict(w);
    w2 = sin((1:n./2-1).*k.*pi.*2./n)';
    w2cos = w2.*cos(k.*pi./2./n).^2;
    disp("Restriction error for k=" + k + ":");
    disp(norm(res_w-w2cos, Inf));
    
    interp_w = interpolate(w2);
    wnk = sin((1:n-1).*(n-k).*pi./n)';
    wcos = w.*cos(k.*pi./2./n).^2;
    wnksin = wnk.*sin(k.*pi./2./n).^2;
    lhs = wcos-wnksin;
    disp("Interpolation error for k=" + k + ":");
    disp(norm(interp_w-lhs, Inf));
end