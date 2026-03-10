%Defining Parameters
L = 2*pi; % sampling points on circle
N = 64; 
dx = L/N;
x = (0:N-1)*dx; 

%Periodic Function
u=exp(-sin(x/2).^2)


%Fourier Transform
u_hat=fft(u);

% 2. Define the correct Wavenumber vector (k)
% This matches the order of fft(u)
k = (2*pi/L) * [0:N/2-1, 0, -N/2+1:-1]';
% []' the quotation mark is for transposing 

% 3. Inverse Transform to get back to physical space
u_recovered = real(ifft(u_hat)); 

% --- VISUALIZATION ---
figure('Position', [100, 100, 1000, 400]);

% Plot 1: Physical Space (The "Function")
figure(1); 
plot(x, u, 'LineWidth', 2);
title('Physical Space: u(x)');
grid on;

% Plot 2: Fourier Space (The "Matrix/Coefficients")
% We use fftshift to put 0 in the middle for easier viewing
figure(2); 
stem(fftshift(k), abs(fftshift(u_hat))/N, 'filled');
title('Frequency Space: |\hat{u}(k)|', 'Interpreter', 'none');
grid on;
