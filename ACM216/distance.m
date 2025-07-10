function d = distance(cityindex1, cityindex2, CAtowns)
    d = 0;
    if CAtowns(cityindex1,3) ~= CAtowns(cityindex2,3)
       d = d + 1e7;
    end
    c1x = CAtowns(cityindex1, 1);
    c1y = CAtowns(cityindex1, 2);
    c2x = CAtowns(cityindex2, 1);
    c2y = CAtowns(cityindex2, 2);
    d = d + sqrt((c1x-c2x).^2 + (c1y-c2y).^2);
end