function [Q,R] = clgs(A)
    r11 = norm(A(:,1));
    q1 = A(:,1)./r11;
    q=q1;
    size_A = size(A);
    r = zeros(size_A(2));
    r(1,1) = r11;
    for j = 2:size_A(2)
        for i = 1:(j-1)
            r(i,j) = dot(A(:,j),q(:,i));
        end
        q_hat = A(:,j);
        for i = 1:(j-1)
           q_hat = q_hat - r(i,j).*q(:,i);
        end
        r(j,j) = norm(q_hat);
        if r(j,j) == 0
            disp("RETURNING")
            Q=0;
            R=0;
            return
        else
            new_q = q_hat/r(j,j);
            q = [q new_q];
        end
    end
    Q = q;
    R = r;
end

