ns=[5,10,20];
for i=1:3
    n=ns(i);
    x=[];
    for j=0:n
        val = 5.*cos((2.*j+1)./(2.*n+2).*pi);
        x=[x val];
    end
    y=1./(1+x.^2);
    soln=0;
    for k=1:length(x)
        a=1;
        b=1;
        for j=1:length(x)
            if j~=k
                a = poly(x(j))/(x(k)-x(j));
                b = conv(b,a);
            end
        end
        soln = soln + b.*y(k);
    end
    figure;
    plot(x,soln);
    hold on;
    x2 = -5:0.01:5;
    y2 = 1./(1+x2.^2);
    plot(x2,y2);
    plot(x,y);
end