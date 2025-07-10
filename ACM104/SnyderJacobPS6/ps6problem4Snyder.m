n=10000;
m=2;
centroid = mean(X');
modX = X - centroid';
covar = (1/n).*(modX*modX');

disp('Covariance matrix: ');
disp(covar);

[eigenvectors,temp] = eig(covar);

fin = [];
for i = 1:m
   mag = norm(eigenvectors(:,i));
   uni = eigenvectors(:,i) ./ mag;
   fin = [fin, uni];
end
eigenvectors = fin;

disp('Principal components: ');
disp(eigenvectors);

scatter(X(1,:), X(2,:));
ph = -5;
line([5.*eigenvectors(1)+centroid(1), ph.*eigenvectors(1)+centroid(1)], [5.*eigenvectors(2)+centroid(2), ph.*eigenvectors(2)+centroid(2)],'Color','red');
line([5.*eigenvectors(3)+centroid(1), ph.*eigenvectors(3)+centroid(1)], [5.*eigenvectors(4)+centroid(2), ph.*eigenvectors(4)+centroid(2)],'Color','red');

Y = eigenvectors\X;
centroidY = mean(Y');
modY = Y - centroidY';
covar2 = (1/n) .* (modY*modY');

disp('Modified covariance matrix: ');
disp(covar2);

eigenvectors2 = pca(X');

disp('PCA principal components: ');
disp(eigenvectors2);