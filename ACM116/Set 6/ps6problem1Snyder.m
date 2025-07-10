M = 1e5;
lambda = 5;
p = 0.1;
critfail = 10;

failtimes = 0;
validfailures = 0;
for a = 1:M
    timewaited = 0;
    failroll = 1;
    count = 0;
    
    while failroll > 0.1
        timewaited = timewaited + exprnd(1/lambda);
        failroll = rand();
        count = count + 1;
        if count > critfail
           break; 
        end
    end
    
    if count == critfail
       validfailures = validfailures + 1;
       failtimes = failtimes + timewaited;
    end
end

avgfailtime = failtimes./validfailures;

disp('Average waiting time for failure given that the system fails on the 10th shock: ');
disp(avgfailtime);