clear all;
clc;
L=128;% System size
N=9000; % Total no. of iterations
delt=0.1;% temporal step size/resolution
delx=0.3; % spatial step size/resolution
D=0.09;% Diffusion constant
c=zeros(L,1);
c0=zeros(L,1);
K=2*pi/(L*delx)*[0:L/2-1 -L/2:-1]; % k modes
x=1:L;
c0=exp(-((x-L/2)*delx/5).^2); % Gaussian initial condition
c=c0;
cc=fft(c);

for i=1:N % temporal loop
    for p=1:L % mode-number loop
        cc(p)=cc(p)-D*delt*K(p)^2*cc(p);
    end
    %cc=cc-D*delt*K.^2.*cc;
    cT(:,i)=real(ifft(cc));
end
%Neumann_par=D*delt/delx/delx


 for i=1:10:N
     plot(cT(:,i));ylim([0 1]);
     pause(0.001);
 end