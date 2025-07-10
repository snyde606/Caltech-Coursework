% p27.m - Solve KdV eq. u_t + uu_x + u_xxx = 0 on [-pi,pi] by
%         FFT with integrating factor v = exp(-ik^3t)*u-hat.

% Set up grid and two-soliton initial data:
  N = 256; dt = .01/N^2; x = (2*pi/N)*(-N/2:N/2-1)';
  A = 25; B = 16; clf, drawnow, set(gcf,'renderer','zbuffer')
  u = 3*A^2*sech(.5*(A*(x+2))).^2 + 3*B^2*sech(.5*(B*(x+1))).^2; 
  v = fft(u); k = [0:N/2-1 0 -N/2+1:-1]'; ik3 = 1i*k.^3;

% Solve PDE and plot results:
  tmax = 0.006; nplt = floor((tmax/25)/dt); nmax = round(tmax/dt);
  udata = u; tdata = 0; h = waitbar(0,'please wait...');
  for n = 1:nmax
    t = n*dt; g = -.5i*dt*k;
    a = g.*fft(real( ifft(     v    ) ).^2)+ik3.*v.*dt;
    b = g.*fft(real( ifft((v+a/2)) ).^2)+ik3.*(v+a/2).*dt;     % 4th-order
    c = g.*fft(real( ifft(v + b/2) ).^2)+ik3.*(v+b/2).*dt;     % Runge-Kutta
    d = g.*fft(real( ifft(v+c) ).^2)+ik3.*(v+c).*dt;
    v = v + (a + 2.*(b+c) + d)/6;
    if mod(n,nplt) == 0 
      u = real(ifft(v)); waitbar(n/nmax)
      udata = [udata u]; tdata = [tdata t];
    end
  end
  waterfall(x,tdata,udata'), colormap(1e-6*[1 1 1]); view(-20,25)
  xlabel x, ylabel t, axis([-pi pi 0 tmax 0 2000]), grid off
  set(gca,'ztick',[0 2000]), close(h), pbaspect([1 1 .13])