function [k,astar] = pinpoint(f, df,xk,pk, alow,ahigh,phi0,philow,phihigh,phip0,phiplow,phiphigh,mu1,mu2)

phi    = @(a) f(xk+a*pk);
phip = @(a) df(xk+a*pk)'*pk;

k=0;
prevasp = i;
asp = 0.5.*(alow+ahigh);
while true
    if abs(prevasp-asp)<1e-4
        astar = asp;
        return;
    end
    prevasp = asp;
    phisp = phi(asp);
    if asp~=0
        disp(asp);
    end
    if phisp > phi0 + mu1.*asp.*phip0 | phisp > philow
        ahigh = asp;
    else
        phipsp = phip(asp);
        if abs(phipsp) <= -mu2.*phip0
            astar = asp;
            return;
        elseif phipsp.*(ahigh-alow) >= 0
            ahigh = alow;
        end
        alow = asp;
    end
    k = k+1;
    asp = 0.5.*(alow+ahigh);
end

end
