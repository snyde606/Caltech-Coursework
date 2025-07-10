function H = TridiagonalQRGivensShift(H)
    eps = 0.001;
    H_prev = H;
    n = size(H,1);
    G_is = [];
    while true
        M = H_prev;
        %get shift
        B = M(n-1:n,n-1:n);
        delta = (B(1,1)-B(2,2))./2;
        shift = B(2,2)-sign(delta).*(B(2,1).^2)./(abs(delta)+sqrt(delta.^2+B(2,1).^2));
        M = M - shift.*eye(n);
        %algo
        for i=1:(n-1)
            [c,s] = Givens(M(i,i), M(i+1,i));
            G_is = [G_is; c s];
            G_i = [c -s; s' c'];
            M(i:(i+1),i:min(i+2,n)) = G_i*M(i:(i+1),i:min(i+2,n));
        end
        for i=1:(n-1)
            c = G_is(i,1);
            s = G_is(i,2);
            G_i = [c -s; s' c'];
            M(i:(i+1),i:(i+1)) = M(i:(i+1),i:(i+1))*G_i';
            M(i,i+1) = M(i+1,i)';
        end
        H_prev = diag(diag(M,-1),-1) + diag(diag(M)) + diag(diag(M,1),1);
        H_prev = H_prev + shift.*eye(n);
        pass = true;
        for j=1:n-2
            A_k = H_prev(j:(j+2),j:(j+2));
            if abs(A_k(2,1))>eps || abs(A_k(3,2))>eps
                pass = false;
                break;
            end
        end
        if pass
            H = H_prev;
            break;
        end
    end
end