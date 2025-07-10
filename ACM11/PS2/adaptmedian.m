%2d
function iRes = adaptmedian(iTil,wmax)
    %get M and N
    siz = size(iTil);
    dim1 = siz(1);
    dim2 = siz(2);
    
    %iterate through iTil
    iRes = zeros(dim1,dim2);
    for i=1:dim1
       for j=1:dim2
           w=3; %step 1
           med = 0;
           while w <= wmax % while loop iterating w+=2 until >wmax
               medarray = [];
               
               %iterate through window
               for wi=(i-(w-1)./2):(i+(w-1)./2)
                   for wj=(j-(w-1)./2):(j+(w-1)./2)
                       if wi>=1 && wi<=dim1 && wj>=1 && wj<=dim2
                           medarray = [medarray iTil(wi,wj)]; %build window matrix
                       end
                   end
               end
               %get smin, smedian, smax (step 2)
               mn = min(medarray);
               med = median(medarray);
               mx = max(medarray);
               if mn < med && med < mx %step 3
                   if iTil(i,j) <= mn || iTil(i,j) >= mx %step 5
                       iRes(i,j) = med;
                       break;
                   else
                       iRes(i,j) = iTil(i,j);
                       break;
                   end
               end
               w = w+2; %while loop iteration change
           end
           if w>wmax % step 4
               iRes(i,j) = med;
           end
       end
    end
    iRes = uint8(iRes);
end