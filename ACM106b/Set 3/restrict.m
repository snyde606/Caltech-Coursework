function nv = restrict(v) 
    vm1=zeros(size(v));
    vp1=zeros(size(v));
    vm1(2:end)=v(1:end-1);
    vp1(1:end-1)=v(2:end);
    intermed = vm1+2.*v+vp1;
    nv = 1./4.*intermed;
    nv = nv(2:2:end-1);
end