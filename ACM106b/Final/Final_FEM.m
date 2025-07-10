
% CODE DOES NOT RUN !! INCOMPLETE IMPLEMENTATION

% Stuck on the implementation of the basis function values. I suspect that
% my problem setup is flawed; it's unclear to me exactly how to define the
% nodal basis functions in between the x_i. Low-degree implementations send
% the second derivative to zero yielding an empty stiffness matrix - this
% seems wrong? Also the output vector would be giving one value per v_j - I
% don't see how this would translate to a cubic. Overall I'm stuck on the
% implementation of this FEM.

f = @(x) exp(x).*(x.^4+14.*x.^3+49.*x.^2+32.*x-12);
exact_soln = @(x) exp(x).*x.^2.*(1-x).^2;

for p=1:10
    n = 10.*p;
    
    % construction of phi and phiprime matrices - stuck on this

    xs = ((1:n)-1)./n;
    phi_mat = phi(xs);
    phiprime_mat = phiprime(xs);
    a_vec = a(xs);
    f_vec = f(xs);

    % construct load vector and stiffness matrix
    A=zeros(n,n);
    b=zeros(n,1);
    for i=1:n
        for j=1:n
            aij = a_vec.*phiprime_mat(i,:).*phiprime_mat(j,:);
            A(i,j) = 1./n.*sum(aij);
        end
        aij = f_vec.*phi_mat(i,:);
        b(i) = 1./n.*sum(aij);
    end

    soln = A\b;
end
