%MATLAB code for solving laplace equation by Method of Relaxation

clear all;
clc;
L=20; % System Size
N=500; % Total no. of iterations
delx=0.0001; % Spatial resolution
V=rand(L,L);% initial condition
%boundary conditions
V(:,1)=1; 
V(:,L)=1;
V(1,:)=0;
V(L,:)=0;
%%%%%%%%%%%%%%%%
Vo=V;
for i=1:N
    for p=2:L-1
        for q=2:L-1
            V(p,q)=1/4*(V(p+1,q)+V(p-1,q)+V(p,q+1)+V(p,q-1));
        end
        VT(:,:,i)=V;
    end
end
surf(V);
% VT(:,:,i) saves the timelapse values of V. USe it to plot the value of ...
% V at different time points, e.g., surf(V(:,:,1)) at time i=1 and
% surf(V(:,:,10)) at time i=10.
