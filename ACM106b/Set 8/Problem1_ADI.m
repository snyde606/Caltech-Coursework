% The final plot appears to roughly resemble the exact solution. However,
% the max error increases as mesh size decreases, so there's something off.
% I can't seem to find the problem although it might have to do with the
% implementation of the boundary conditions.
% Overall though, the max error seems to be low enough that this is
% probably very close to the correct implementation.

u0 = @(x,y) sin(0.5.*(x-y)).*cosh(x+y);
exact_solution = @(x,y,t) exp(1.5.*t).*sin(0.5.*(x-y)).*cosh(x+y);

ps=[0 1 2 3 4];
max_error_log = zeros(5,1);
OOC_log = zeros(4,1);
for p_index=1:5
    p=ps(p_index);
    h = 0.1.*2.^(-p);
    m = 1./h;
    k=h;
    mu=1;
    t = [0:k:1];
    t_len = size(t,2)-1;
    x = [0:h:1];
    x_len = size(x,2)-2;

    dm = [ones(x_len-1,1).*(-0.5.*mu)];
    d0 = [ones(x_len,1).*(1+mu)];
    dp = [ones(x_len-1,1).*(-0.5.*mu)];
    A = diag(d0)+diag(dm,-1)+diag(dp,1);

    u = zeros(x_len, x_len);
    u_star = zeros(x_len, x_len);

    for i=1:m-1
        for j=1:m-1
            u(i,j) = u0(x(i+1),x(j+1));
        end
    end

    timer=0;
    for time_index=1:t_len

        for j=1:m-1
            b = zeros(m-1,1);
            if j~=1 & j~=m-1
                b = 0.5.*mu.*u(1:m-1,j-1)+(1-mu).*u(1:m-1,j)+0.5.*mu.*u(1:m-1,j+1);
            elseif j==1
                b = (1-mu).*u(1:m-1,j)+0.5.*mu.*u(1:m-1,j+1);
                y0_boundary = g(x(1:m+1),0,timer)';
                b = b + 0.5.*mu.*y0_boundary(2:m);
            elseif j==m-1
                b = 0.5.*mu.*u(1:m-1,j-1)+(1-mu).*u(1:m-1,j);
                y1_boundary = g(x(1:m+1),1,timer)';
                b = b + 0.5.*mu.*y1_boundary(2:m);
            end
            x0_boundary = u_star_boundary(0,timer,m,h);
            b(1) = b(1) + 0.5.*mu.*x0_boundary(j+1);
            x1_boundary = u_star_boundary(1,timer,m,h);
            b(end) = b(end) + 0.5.*mu.*x1_boundary(j+1);
            u_star(:,j) = A\b;
        end

        for i=1:m-1
            b = zeros(m-1,1);
            if i~=1 & i~=m-1
                b = 0.5.*mu.*u_star(i-1,1:m-1)+(1-mu).*u_star(i,1:m-1)+0.5.*mu.*u_star(i+1,1:m-1);
            elseif i==1
                b = (1-mu).*u_star(i,1:m-1)+0.5.*mu.*u_star(i+1,1:m-1);
                x0_boundary = u_star_boundary(0,timer,m,h)';
                b = b + 0.5.*mu.*x0_boundary(2:m);
            elseif i==m-1
                b = 0.5.*mu.*u_star(i-1,1:m-1)+(1-mu).*u_star(i,1:m-1);
                x1_boundary = u_star_boundary(1,timer,m,h)';
                b = b + 0.5.*mu.*x1_boundary(2:m);
            end
            y0_boundary = g(x(i+1),0,timer+k);
            b(1) = b(1) + 0.5.*mu.*y0_boundary;
            y1_boundary = g(x(i+1),1,timer+k);
            b(end) = b(end) + 0.5.*mu.*y1_boundary;
            temp = A\b';
            u(i,:) = temp';
        end

        timer = timer + k;
    end

    soln_matrix = zeros(m-1,m-1);
    for i=1:m-1
        soln_matrix(i,:) = exact_solution(x(i+1),x(2:m),1);
    end
    
    max_error = max(abs(soln_matrix-u),[],'all');
    max_error_log(p_index) = max_error;
    if p_index~=1
        OOC=log2(abs(max_error_log(p_index-1)/max_error_log(p_index)));
        OOC_log(p_index-1) = OOC;
    end
    
end

figure;
surf(x(2:m),x(2:m),u);
title("mesh size h="+h);
disp(max_error);


function z = u_star_boundary(x,time,m,h)
    xs = [0:h:1];
    gn = g(x,xs(1:m+1),time)';
    gnp1 = g(x,xs(1:m+1),time+h)';
    z = gn+0.5.*h.*d2yun(gn,h)+gnp1-0.5.*h.*d2yun(gnp1,h);
end

function a = d2yun(gn,h)
    sz = max(size(gn));
    A = diag(-2.*ones(sz,1))+diag(ones(sz-1,1),1)+diag(ones(sz-1,1),-1);
    A = A./(h.^2);
    a = A*gn;
end

function a = g(x,y,t)
    a=exp(1.5.*t).*sin(0.5.*(x-y)).*cosh(x+y);
end