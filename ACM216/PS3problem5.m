T=10;

load('CAtowns.mat');
assign = ones(size(CAtowns,1),1);
for a=1:size(assign)
   assign(a)=a; 
end

for a=1:100000000
    nrand = randi([1 (size(CAtowns,1)-1)],1,1);
    oldcost = 0;
    newcost = 0;
    if nrand ~= 1
       oldcost = oldcost + distance(assign(nrand-1), assign(nrand), CAtowns);
       newcost = newcost + distance(assign(nrand-1), assign(nrand+1), CAtowns);
    end
    oldcost = oldcost + distance(assign(nrand), assign(nrand+1), CAtowns);
    newcost = newcost + distance(assign(nrand+1), assign(nrand), CAtowns);
    if nrand ~= size(CAtowns,1)-1 
        oldcost = oldcost + distance(assign(nrand+1), assign(nrand+2), CAtowns);
        newcost = newcost + distance(assign(nrand), assign(nrand+2), CAtowns);
    end
    assigndiff = newcost-oldcost;
    critval = exp(-1./T.*assigndiff);
    hval = min([1 critval]);
    rval = rand();
    if rval < hval
        old = assign(nrand);
        assign(nrand) = assign(nrand+1);
        assign(nrand+1) = old;
    end
end

totalcost = 0;
for a=1:(size(assign)-1)
   totalcost = totalcost + distance(assign(a), assign(a+1), CAtowns);
end
totalcost = totalcost - 58.*1e7;

disp(totalcost);
