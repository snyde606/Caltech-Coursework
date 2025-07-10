function [tn_history,yn_history, yn0] = RKFinal(y0, h)
    fun = @(y1, y2) [y2; (1-y1.^2).*y2-y1];

    s=3;
    n_max = 6.*pi./h;
    A = [1./3 0; 0 2./3];
    b = [1./4 0 3./4];
    c = [0 1./3 2./3];
    yn0 = y0;
    %disp(yn0);
    k_hist = fun(yn0(1), yn0(2));
    tn=0;
    tn_history = tn;
    yn_history = yn0;
    
    for n=1:n_max
        tn=tn+h;
        k_hist = fun(yn0(1), yn0(2));
        for i=1:s-1
            yni = yn0 + h.*sum(A(i,1:i).*k_hist(1:i));
            k_hist = [k_hist fun(yni(1), yni(2))];
        end
        %disp("yn0 before");
        %disp(yn0);
        %disp("khist");
        %disp(k_hist);
        %disp("sum khist");
        %disp(h.*sum(b.*k_hist,2));
        yn0 = yn0 + h.*sum(b.*k_hist,2);
        %disp("yn0 after");
        %disp(yn0);
        tn_history = [tn_history tn];
        yn_history = [yn_history yn0];
    end
    
end