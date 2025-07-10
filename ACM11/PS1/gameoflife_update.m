function new_status = gameoflife_update(status)
    %Get and store dimensions of the input matrix
    sz = size(status);
    dim1 = sz(1);
    dim2 = sz(2);
    
    %For loop to run through the status matrix and accumulate totals for
    %adjacent cells
    totals = zeros(dim1,dim2); %initialize totals matrix
    for a=1:dim1 %loop through the status matrix
       for b=1:dim2
           if a~=1 %checks to ensure we aren't on any edges of the status matrix so as to avoid going out of bounds with indexing
              totals(a,b) = totals(a,b) + status(a-1,b); %add to the totals matrix whether or not there is an adjacent living cell
              if b~=1
                  totals(a,b) = totals(a,b) + status(a-1,b-1);
              end
              if b~=dim2
                  totals(a,b) = totals(a,b) + status(a-1,b+1);
              end
           end
           if a~=dim1
              totals(a,b) = totals(a,b) + status(a+1,b);
              if b~=1
                  totals(a,b) = totals(a,b) + status(a+1,b-1);
              end
              if b~=dim2
                  totals(a,b) = totals(a,b) + status(a+1,b+1);
              end
           end
           if b~=1
               totals(a,b) = totals(a,b) + status(a,b-1);
           end
           if b~=dim2
               totals(a,b) = totals(a,b) + status(a,b+1);
           end
       end
    end
    
    %initialize new status matrix
    new_status = zeros(dim1,dim2);
    new_status(status==1 & totals>=2) = 1; %check for cells that remain alive
    new_status(status==1 & (totals<=1 | totals>=4)) = 0; %kill cells that should not remain alive
    new_status(status==0 & totals==3) = 1; %spawn new cells for those that had exactly 3 adjacent ones
end