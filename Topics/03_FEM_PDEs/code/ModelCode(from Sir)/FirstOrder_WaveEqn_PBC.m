%MATLAB code for solving first order wave eqn with PBC 

close all;
clear all;
clc;
L=100;% System size
N=500; % Total no. of iterations
delt=0.1;% temporal step size/resolution
delx=0.1; % spatial step size/resolution
v=1;

%%% Initialize matrices to zero %%%
c=zeros(L,1); % concentration field
c0=zeros(L,1); % initial concentration field
ctemp=zeros(L,1);
%%%%%%%%%%%%%%%%%%%%%%
x=1:L;% grid points of the domain
c0=exp(-((x-30)*delx).^2);%1; % initial condition of the concentration field
c=c0; % initialize the concentration field

for i=1:N
    %periodic Boundary condition
    c(1)=c(L-1);
    c(L)=c(2);
    for p=2:L-1
            
            ctemp(p)=c(p)-v*delt/delx*(c(p)-c(p-1));
    end
    c=ctemp;
    cT(:,i)=c;
    n(i)=sum(c,'all');
end

CFL_par=v*delt/delx

for i=1:1:N
    plot(cT(2:L-1,i));ylim([0 1]);
    pause(0.0001);
end
