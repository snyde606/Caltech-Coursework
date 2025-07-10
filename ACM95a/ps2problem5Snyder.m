function [X, Y] = branch_val(x,y)
    if y <= -1 & x==0
        error("Error!  z=(%f,%f) belongs to the branch cut on theta = pi/2",x,y)
    elseif y >= 1 & x==0
        error("Error!  z=(%f,%f) belongs to the branch cut on theta = pi/2",x,y)
    else
        atop = sqrt(x^2+1+y^2-2*y);
        abot = sqrt(x^2+1+y^2+2*y);
        a = log(atop/abot)/2;
        tantop = x*(1+y)+x*(1-y);
        tanbot = (1-y)*(1+y)-x^2;
        b = atan2(tantop,tanbot)/2+pi;
        X = exp(a)*cos(b);
        Y = exp(a)*sin(b);
    end
end 