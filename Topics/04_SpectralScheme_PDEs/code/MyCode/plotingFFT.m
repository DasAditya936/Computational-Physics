L = 100;                 % Domain length
N = 1024;                % Number of points
dx = L/N;                % Grid spacing
x = (0:N-1)*dx;          % Space vector

% Creating functions- Tweak with them to see how things change 
% Pulse A: Centered at 30, vibrating at k=2
pulseA = exp(-(x-30).^2/20) .* cos(2 * x); 

% Pulse B: Centered at 70, vibrating at k=8
pulseB = exp(-(x-70).^2/10) .* cos(8 * x);

%Combined Pulse
psi = pulseA + pulseB;

% Define the Wavenumbers (k)
% Recall: k = 2*pi/L * [0:N/2-1, -N/2:-1] 
dk = 2*pi/L;
k = dk * [0:N/2-1, -N/2:-1];


%Performing FFTs
psi_hat = fft(psi);
k_plot = fftshift(k);
mag_plot = fftshift(abs(psi_hat));

%PLOTTING
figure;
subplot(2,1,1); plot(x, psi, 'LineWidth', 1.5); 
title('Real Space: Two Vibrating Pulses'); grid on;

subplot(2,1,2); plot(k_plot, mag_plot, 'r', 'LineWidth', 1.5); 
title('Frequency Space: Multiple Distinct Spectral Peaks'); grid on;