regdata = []
for nfake = 1:10
    n = 10 * nfake;
    H = hilb(n);
    basis = H(:,1);
    for index = 2:n
        wk = H(:,index);
        sum = [0];
        for sindex = 1:index-1
            sum = sum + dot(wk, basis(:,sindex))./(norm(basis(:,sindex)).^2) .* basis(:,sindex);
        end
        basis = [basis, wk - sum];
        
    end
    for i = 1:n
        basis(:,i) = basis(:,i)./norm(basis(:,i));
    end
    regdata = [regdata; n, norm(eye(n) - basis'*basis, Inf)];
end
disp(regdata);



stabledata = []
for nfake = 1:10
    n = 10 * nfake;
    H = hilb(n);
    ws = H;
    basis = ws(:,1)./norm(ws(:,1));
    for j = 2:n
        for k = j:n
            wkj = ws(:,k);
            uj = basis(:,j-1);
            ws(:,k) = wkj - dot(wkj, uj) * uj;
            if j==k
                basis = [basis, ws(:,k)/norm(ws(:,k))];
            end
        end
    end
    stabledata = [stabledata; n,norm(eye(n) - basis'*basis,Inf)];
end
disp(stabledata);

plot(regdata(:,1), regdata(:,2))
hold on;
plot(stabledata(:,1), stabledata(:,2))
legend('delta_V(n)', 'delta_U(n)')
