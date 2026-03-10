%MATLAB code for 2nd Order WaveEqn-Fixed Boundary Condition

close all;
clear all;
clc;
L=100;% system size
N=1000; % No. of iterations
delt=1e-4;% temporal step size
delx=1e-2;% spatial step size
v=100;% wave speed
K=delt^2*v^2/delx/delx; % CFL parameter

%Initialze matrices to zero
u=zeros(L,1); % current displacement field
u0=zeros(L,1); % initial displacement field
v0=zeros(L,1); % initial velocity field
unext=zeros(L,1);% next time-step displacement field
uprev=zeros(L,1); % previous time-step displacement field


x=(1:L)*delx;
u0(1:L)=exp(-100*(x-L*delx/2).^2);
uprev=u0;
v0(1:L)=-200*v*(x-L*delx/2).*exp(-100*(x-L*delx/2).^2);% initial condition for a left-ward travelling wave
%boundary condition
u(1)=0;
u(L)=0;

% Calculating u for the first timestep using the information of the initial wave velocity
for p=2:L-1
u(p)=K/2*(u0(p+1)+u0(p-1))+(1-K)*u0(p)+delt*v0(p);
end

%%% Main body of the code
for i=1:N %time loop
    for p=2:L-1 % spatial loop
        unext(p)=K*(u(p+1)+u(p-1))+2*(1-K)*u(p)-uprev(p);
    end
    uprev=u;
    u=unext;
    uT(:,i)=u;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:1:N
    plot(uT(:,i));ylim([-1 1]);
    pause(1e-5);
end
