function [ct,astar] = bracketing(f, df,xk,pk, ainit,phi0,phip0,mu1,mu2,sigma)

phi    = @(a) f(xk+a*pk);
phip = @(a) df(xk+a.*pk)'*pk;

a1 = 0;
a2 = ainit;
phi1 = phi0;
phip1 = phip0;
first = true;
ct=1;
while true
    ct=ct+1;
    disp("bracketing while start");
    phi2 = phi(a2);
    phip2 = phip(a2);
    if phi2 > (phi0 + mu1.*a2.*phip0) | (~first & phi2 > phi1)
        disp("starting pinpoint1");
        [ct,astar] = pinpoint(f,df,xk,pk,a1,a2,phi0,phi1,phi2,phip0,phip1,phip2,mu1,mu2);
        disp("finished pinpoint1");
        return;
    end
    if abs(phip2) <= -mu2.*phip0
        astar = a2;
        return;
    elseif phip2 >= 0
        disp("starting pinpoint2");
        [ct,astar] = pinpoint(f,df,xk,pk,a1,a2,phi0,phi1,phi2,phip0,phip1,phip2,mu1,mu2);
        disp("finished pinpoint2");
        return;
    else
        a1 = a2;
        phi1 = phi2;
        phip1 = phip2;
        a2 = sigma.*a2;
    end
    first = false;
end

end
