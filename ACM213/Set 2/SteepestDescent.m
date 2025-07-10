data = readtable('data_normalized.csv');
data = data{:,:};
inputs = data(:,1:48);
outputs = data(:,49);
inputsp1 = [inputs, ones(200,1)];

lambda = 1e-2;
m=200;
stepsize = 3e-3;

obf = @(theta,xi,yi) 1./2.*(theta'*[xi;1]-yi).^2+lambda./(2.*m)*theta'*theta;
dobf = @(theta,xi,yi) (2.*[xi,1]*(theta'*[xi';1]-yi)+lambda./m.*theta')';
f = @(theta) 1./(2.*m).*sum((theta'*inputsp1'-outputs').^2)+lambda./2.*theta'*theta;
df = @(theta) (1./m*sum(inputsp1).*sum(theta'*inputsp1'-outputs')+lambda*theta')';

xk = zeros(49,1);

mu1 = 1e-5;
mu2 = 1e-4;
sigma = 1.5;

lastxk = ones(49,1);
xkhistory = [xk];
losshistory = [f(xk)];
ct1=0;
while norm(xk-lastxk) > 0.01.*norm(xk)
    
    i=randi(200);
    sample = inputs(i,:);
    sampley = outputs(i);
    sampdf = dobf(xk,sample,sampley);
    pk = -sampdf./norm(sampdf);
    
    %phi = @(a) f(xk+a.*pk);
    %phip = @(a) df(xk+a.*pk)'*pk;
    %phi0 = phi(0);
    %phip0 = phip(0);
    %[ct,astar1] = bracketing(f, df,xk,pk, ainit,phi0,phip0,mu1,mu2,sigma);
    lastxk = xk;
    if ct1>5
        xk = xk+stepsize.*pk;
    else
        xk = xk+stepsize.*pk;
    end
    xkhistory = [xkhistory, xk];
    losshistory = [losshistory, f(xk)];
    ct1 = ct1+1;
end

figure;
scatter(linspace(1,size(xkhistory,2),size(xkhistory,2)),log(losshistory));
xlabel('iteration #');
ylabel('ln(loss function)');
title("SGD, stepsize = 0.003, Mu1=1e-5, Mu2=1e-4, sigma=1.5");