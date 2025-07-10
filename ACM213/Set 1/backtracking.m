function [ct,alf,ahist] = backtracking(f,df,xk,pk,mu1,alf0,rho)

phi    = @(a) f(xk+a*pk);
phi0pr = df(xk)'*pk;

alf = alf0;
ahist = alf;
ct=0;
for i = 1:100
    ct = ct + 1;
    if phi(alf) <= phi(0) + mu1*alf*phi0pr
        break
    end
    alf = rho*alf;
    ahist = [ahist, alf];
end
if i == 100
    warning('Backtracking exited without satsifying Armijo condition.')
end
