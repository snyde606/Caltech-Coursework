covw = [1/12 1/12 1/12; 1/12 29/12 1/12; 1/12 1/12 13/12];
[V,D] = eig(covw);
Qt = transpose(V);

disp("Decorrelating transformation for W: ");
disp(Qt);