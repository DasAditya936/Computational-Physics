clear all
clc

delt=0.1; % temporal resolution
delx=0.5; % spatial resolution
D=0.15; % diffusion constant
L=128;% no. of grid points (system size)
N=3000; % no. of iterations
x=1:L; % position vector

c0=exp(-((x)*delx).^2/100); % initial condition
c=c0;
cc=fft(c);
U=-cos(2*pi/L*(x-L/2)); % potential
Up=2*pi/L/delx*sin(2*pi/L*(x-L/2)); %gradient of the potential
K=2*pi/(L*delx)*[0:L/2-1,-L/2:-1]; % k modes
%K(L/2) = 0; % Explicitly zeroing the Nyquist frequency 
cT = zeros(L,N); % To avoid Dynamic Memory Allocation- better efficiency

for i=1:N
    rho=Up.*c;
    crho=fft(rho);
    cc=cc+delt*(-D*K.^2.*cc+1i*K.*crho);
    c=real(ifft(cc));
    cT(:,i)=c;
end

for i=1:20:N
     plot(x,cT(:,i),x,U);ylim([-1 2]);xlim([0 L]);
     pause(0.1);
end