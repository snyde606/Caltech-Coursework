function nv = interpolate(v) 
    vsize = size(v,1);
    nv=zeros(vsize*2+1,1);
    nv(2:2:end) = v;
    vinterp = zeros(vsize+1,1);
    vinterp(1:end-1) = v(1:end);
    vinterp(2:end) = vinterp(2:end) + v(1:end);
    vinterp = vinterp./2;
    nv(1:2:end) = vinterp;
end