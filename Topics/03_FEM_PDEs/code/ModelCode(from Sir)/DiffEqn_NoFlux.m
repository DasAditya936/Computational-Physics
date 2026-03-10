%MATLAB code for solving diffusion with no-flux boundary condition.

%Tracking change, to see whether the cpsync works or not

clear all;
clc;
L=30;% System size
N=1000; % Total no. of iterations
delt=0.1;% temporal step size/resolution
delx=0.15; % spatial step size/resolution
D=0.02;% Diffusion constant

%%% Initialize matrices to zero %%%
c=zeros(L,L); % concentration field
c0=zeros(L,L); % initial concentration field
ctemp=zeros(L,L);
%%%%%%%%%%%%%%%%%%%%%%
c0(L/2,10)=1; % initial condition of the concentration field
c=c0; % initialize the concentration field

for i=1:N
   %Noflux Boundary condition; 
    c(1,:)=c(2,:);
    c(L,:)=c(L-1,:);
    c(:,1)=c(:,2);
    c(:,L)=c(:,L-1);
    for p=2:L-1
        for q=2:L-1
            nL=c(p,q-1);
            nR=c(p,q+1);
            nT=c(p-1,q);
            nB=c(p+1,q);
            ctemp(p,q)=c(p,q)+D*delt/delx/delx*(nL+nR+nT+nB-4*c(p,q));
        end
    end
    c=ctemp;
    cT(:,:,i)=c;
    n(i)=sum(c,'all');
end
Neuman_para=D*delt/delx/delx
for i=1:2:N
    imagesc(cT(1:L,1:L,i));colorbar;
    pause(0.001);
end
plot(n);
ylabel('C(concentration field)');
xlabel('time');
