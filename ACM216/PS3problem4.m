theta = 1;
T=1;

data = imread('cows.JPG');
data2 = double(rgb2gray(data));
assign = data2./111.0 - 1;
data2 = assign;
assign(assign>=0)=1;
assign(assign<0)=-1;

for a=1:10000000
    xrand = randi([1 size(data,1)],1,1);
    yrand = randi([1 size(data,2)],1,1);
    sumsurr = 0;
    if xrand~=1
       sumsurr = sumsurr + assign(xrand-1,yrand);
    end
    if xrand~=size(data,1)
       sumsurr = sumsurr + assign(xrand+1,yrand);
    end
    if yrand~=1
       sumsurr = sumsurr + assign(xrand,yrand-1);
    end
    if yrand~=size(data,2)
       sumsurr = sumsurr + assign(xrand,yrand+1);
    end
    assigndiff = (-2.*(sumsurr) - 2.*theta.*data2(xrand,yrand)).*(-assign(xrand,yrand));
    critval = exp(-1./T.*assigndiff);
    hval = min([1 critval]);
    rval = rand();
    if rval < hval
        assign(xrand,yrand) = -assign(xrand,yrand);
    end
end

figure;
imshow(data);

mod1 = data;
mod1(assign==1)=0;
figure;
imshow(mod1);

mod2 = data;
mod2(assign==-1)=0;
figure;
imshow(mod2);
