% Spectral Method for solving Diffusion PDE
clear all;
clc;
L=128;
N=3000; 
delt=0.1;
delx=0.3; 
D=0.005;

% PRE-ALLOCATION (Prevents the index error)
cT = zeros(L, N); 

% FORCE COLUMNS using the ' operator
K = (2*pi/(L*delx)*[0:L/2-1 -L/2:-1])'; 
x = (1:L)'; 

c0 = exp(-((x-L/2)*delx/5).^2); 
c = c0;
cc = fft(c);

for i=1:N % temporal loop
    for p=1:L % mode-number loop
        % This scalar update works regardless of row/column
        cc(p) = cc(p) - D*delt*K(p)^2*cc(p);
    end
    
    % This was the error: real(ifft(cc)) must be a column to fit in cT(:,i)
    cT(:,i) = real(ifft(cc));
end

% Plotting results
%figure;
%waterfall(x, 1:100:N, cT(:, 1:100:N)'); % Plot every 100th time step
%xlabel('Space'); ylabel('Time'); zlabel('Concentration');
%title('1D Diffusion "Melting" over Time');

for i=1:10:N
    plot(x, cT(:,i)); % Plot the concentration at time i
    ylim([0 1]);      % Keep the y-axis steady so you see the drop
    title(['Time Step: ', num2str(i)]);
    pause(0.001);     % Short pause to create animation effect
end