function [Q,R] = mgs(A)
    a = A;
    size_A = size(A);
    r = zeros(size_A(2));
    q = [];
    for i = 1:size_A(2)
        a_i = a(:,i);
        r(i,i) = norm(a_i);
        if r(i,i) == 0
            disp("RETURNING")
            Q=0;
            R=0;
            return
        else
            new_q = a_i/r(i,i);
            q = [q new_q];
        end
        for j = (i+1):size_A(2)
            r(i,j) = dot(a(:,j),q(:,i));
            a(:,j) = a(:,j) - r(i,j).*q(:,i);
        end
    end
    Q = q;
    R = r;
end

