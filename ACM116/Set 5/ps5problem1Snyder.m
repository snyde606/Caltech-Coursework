delt = 30;
W = zeros(10,10000);

for a=1:10000
    waittime = 0;
    for p=1:10
        W(p,a) = waittime;
        data = exprnd(delt);
        if data < delt
            waittime = max(0, waittime - delt + data);
        else
            waittime = waittime + data - delt;
        end
    end
end

W1 = mean(W(1,:));
W2 = mean(W(2,:));
W3 = mean(W(3,:));
W4 = mean(W(4,:));
W5 = mean(W(5,:));
W6 = mean(W(6,:));
W7 = mean(W(7,:));
W8 = mean(W(8,:));
W9 = mean(W(9,:));
W10 = mean(W(10,:));

Ws = [W1 W2 W3 W4 W5 W6 W7 W8 W9 W10];

plot(Ws);
hold on;
scatter([2],[11.036]);