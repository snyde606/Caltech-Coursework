%2c
function iRes = medianfilter(iTil,wsize)
    %get M and N
    siz = size(iTil);
    dim1 = siz(1);
    dim2 = siz(2);
    
    %ensure wsize is odd
    if mod(wsize,2)==0
       wsize = wsize-1;
    end
    
    %iterate through iTil
    iRes = zeros(dim1,dim2);
    for i=1:dim1
       for j=1:dim2
           %fill window array
           medarray = [];
           for wi=(i-(wsize-1)./2):(i+(wsize-1)./2) %iterate through window indices 
               for wj=(j-(wsize-1)./2):(j+(wsize-1)./2) %iterate through window indices
                   if wi>=1 && wi<=dim1 && wj>=1 && wj<=dim2 % verify that we're within domain indices
                       medarray = [medarray iTil(wi,wj)]; % add to window matrix
                   end
               end
           end
           iRes(i,j) = median(medarray); % set iRes value to median of window matrix
       end
    end
    iRes = uint8(iRes); % convert double to uint8
end