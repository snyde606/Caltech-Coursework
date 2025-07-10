function vh = multigrid(b, u0)
    bsize = size(b,1);
    e = ones(bsize,1);
    A = spdiags([-e,2*e,-e],[-1,0,1],bsize,bsize);
    A = (bsize+1).^2.*A;
    if bsize>4
        [vh,ct] = WeightedJacobiSolver(A,b,u0,1,2/3);
        fine_residual = A*vh-b;
        coarse_residual = restrict(fine_residual);
        v2h = zeros(size(coarse_residual));
        v2h = multigrid(coarse_residual, v2h);
        vh = vh-interpolate(v2h);
        [vh,ct] = WeightedJacobiSolver(A,b,vh,1,2/3);
    else
        vh = A\b;
    end
end