function u1 = House(a1)
    r1 = zeros(size(a1));
    r1(1) = norm(a1);
    u1 = (a1+sign(a1(1)).*r1)./norm(a1+sign(a1(1)).*r1);
end