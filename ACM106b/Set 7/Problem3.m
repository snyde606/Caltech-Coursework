lambda = 0.9;

error_log = [];
h=0.02;
k=lambda.*h; %timestep
xs_size = 2./h+1;
start_space = [-1:h:1];

temp = (start_space>=-0.5) & (start_space<=0.5);
temp = temp.*cos(pi.*start_space).^2;
u0=temp;
u1=zeros(size(u0));
u1(2:end) = u0(1:end-1);

t = 0;
u = zeros(1,xs_size);
figure;
while t < 10
    u0(1)=0;
    u0(end)=0;
    u1(1)=0;
    u1(end)=0;

    for j=2:xs_size-1
       u(j) = u0(j)-lambda.*(u1(j+1)-u1(j-1)); 
    end

    u0=u1;
    u1 = u;
    
    u0(1)=0;
    u0(end)=0;
    u1(1)=0;
    u1(end)=0;
    
    t = t+k;
    
    plot(u0)
    axis([0,100,-1,1]);
    drawnow
    
end