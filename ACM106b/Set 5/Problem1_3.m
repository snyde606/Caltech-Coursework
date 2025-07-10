% General form for P_ij(x_kl)
P_ij_kl = @(i,j,k,l) (i+j+1-k-l).*(k+l+1-i-j).*(k-i+1).*(l-j+1).*(-k+i+1).*(j-l+1);

% I'm stumped on how to calculate the a(P_ij, P_kl) pairs short of looping
% with an O(n^6) runtime. Even if I was to implement an O(n^6) loop, I'm
% not sure how I would go about calculating the integral of the gradient product.
% Since P_ij is nonlinear, I don't see any way to simplify the calculation.
% It seems like we have to find gradient functions unique to each (i,j)
% pair and evaluate the integrals using some numerical integration scheme.
% Although this seems possible, this approach seems like it would take a
% lot of time to set up and a VERY long time to run.

% Is there a trick for neatly evaluating these integrals? I feel that a 
% different construction of the P_ij functions might simplify the a(P,P) 
% calculation but no obvious solution presents itself.

% Generic FEM implementation HERE