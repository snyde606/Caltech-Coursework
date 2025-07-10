noisevar = 0.03.^2;
noisevarmat = [noisevar 0; 0 noisevar];

G = [1 2;3 4];
inputs = [];
outputs = [];
predinputs = [];

for a=1:10
   X = normrnd(0,1,2,1);
   W = normrnd(0,noisevar,2,1);
   Y = G*X;
   
   pred = transpose(G)*inv(G*transpose(G)+noisevarmat)*(G*X+W);
   
   inputs = [inputs X];
   outputs = [outputs Y];
   predinputs = [predinputs pred];
end

inputs = transpose(inputs);
predinputs = transpose(predinputs);

scatter(inputs(1:10),inputs(11:20));
hold on;
scatter(predinputs(1:10),predinputs(11:20));