function [c,s] = Givens(a,b)
    if b == 0
        c=1;
        s=0;
    elseif a==0
        c=0;
        s=-1.*sign(b);
    else
        if abs(b)>abs(a)
            tau = -1.*a/b;
            s = 1./sqrt(1+tau.^2);
            c = s*tau;
        else
            tau = -1.*b/a;
            c = 1./sqrt(1+tau.^2);
            s = c*tau;
        end
    end
end