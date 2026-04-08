
<!-- Begin Toc -->

## Table of Contents
[**Diffusion Equation using Spectral Method**](#TMP_2241)
 
[Theory](#TMP_6386)
 
&emsp;&emsp;&emsp;[ $$ \frac{\partial c}{\partial t}=D\frac{\partial^2 c}{\partial x^2 } $$ ](#TMP_8a70)
 
&emsp;&emsp;&emsp;[ $$ \frac{\partial \tilde{c} (k,t)}{\partial t}=-Dk^2 \tilde{c} (k,t) $$ ](#TMP_6428)
 
[Coding/Numerics](#TMP_8e5f)
 
&emsp;[A few things to note:](#TMP_3db7)
 
&emsp;[For loop, for solving the ODE](#TMP_9005)
 
&emsp;[Plotting the Figure](#TMP_05ec)
 
[Miscellany](#TMP_6d66)
 
&emsp;[Generating the GIF file](#TMP_7746)
 
<!-- End Toc -->
<a id="TMP_2241"></a>

# **Diffusion Equation using Spectral Method**
<a id="TMP_6386"></a>

# Theory

We intend to solve the diffusion equation(a PDE):

<a id="TMP_8a70"></a>

### $$ \frac{\partial c}{\partial t}=D\frac{\partial^2 c}{\partial x^2 } $$

using the spectral method. 


In spectral method, we expand the function $c(x,t)$, in terms of spatial fourier modes. When we do that, we get the following ODE:

<a id="TMP_6428"></a>

### $$ \frac{\partial \tilde{c} (k,t)}{\partial t}=-Dk^2 \tilde{c} (k,t) $$
<a id="TMP_3041"></a>

 **We can conclude a number of things from the form, simply by analysis of the above equation such as:** 

1.  Conservation of particle number(the time derivative of the k=0 mode is zero!)
2. Dissipation, i.e. losing energy every time. The amplitude of each k mode is decreasing(because $-Dk^2 <0$ )
3. Dispersion, i.e. broadening of the wave packet is also apparent(take the temporal derivative also, from there we get $\iota \omega =-Dk^2$, meaning that different wavelengths have different $\omega$ $\Longrightarrow$ wave packet broadens)

(The above analysis can be done for any given PDE!)

<a id="TMP_7d51"></a>

**To numerically solve out given PDE, we have to follow the following steps:**

1.  Defining the parameters, initial conditions,and most importantly the k\-modes(very very important).
2. Take the FFT of the function and solve the resulting ODE
3. Take the IFFT of the solution and plot the real part of the IFFT.
<a id="TMP_8e5f"></a>

# Coding/Numerics
```matlab
%Define parameters
L=128; % System size
N=6000; % Number of iteration
delt=0.1; %Spatial resolution
delx=0.3; %Temporal Resolution
D=0.005; % Diffusion Constant

% Initializing the vectors
cT = zeros(L, N);

%Defining the K-mode and x as coloumn vectors. 
K = (2*pi/(L*delx)*[0:L/2-1 -L/2:-1])'; 
x = (1:L)'; 

%Performing the FFT
c0=exp(-((x-L/2)*delx/5).^2); % Gaussian initial condition 
c = c0;
cc = fft(c);
```
<a id="TMP_3db7"></a>

#  A few things to note:
1.  Here, we are dealing with $k^2$, so we need not worry about the k\-mode associated with L/2. Usually we put it to zero, to get rid of ghost terms
2. The array is defined in this particular manner because of how MATLAB interprets the frequencies, first the DC component, then the positive modes, then the negative modes.
3. The K\-modes and x values are defined as coloumn vectors instead of row vectors, because, as seen below, we are calling $\textrm{cT}(:,i)\textrm{,}\;$ where $(:,i)$ targets a particular coloumn. If the K\-modes and x\-values were row vectors instead, $c$, $c_0$ $\textrm{ifft}(c_0 )$ produces a row\-a mismatch in dimension. Although, MATLAB is smart enough to transpose the vector, if we try to force a row into a column\- we might run into trouble later. Better safe than sorry !
4. We are initializing $\textrm{cT}=\textrm{zeros}(L,N)$, to avoid **"*****Dynamic Memory Allocation"****:*

-  MATLAB doesn't know the final size of cT. In every iteration, it must find a new, larger block of memory(RAM), copy all existing data over, and add the new column. This **Dynamic Memory Allocation** forces the CPU to move massive amounts of data unnecessarily, significantly slowing down the code as N increases. 
-  By defining `zeros(L, N)`, you reserve the entire memory block upfront. During the loop, MATLAB simply "drops" the data into the pre\-reserved slot. There is no searching or copying, leading to much faster execution times. It might be not noticeable for small N, but the for larger and larger N, we get noticeable change in execution time.  
<a id="TMP_9005"></a>

# For loop, for solving the ODE 
```matlab
for i=1:N % temporal loop
    for p=1:L % mode-number loop
        % This scalar update works regardless of row/column
        cc(p) = cc(p) - D*delt*K(p)^2*cc(p);
    end
    
    % This was the error: real(ifft(cc)) must be a column to fit in cT(:,i)
    cT(:,i) = real(ifft(cc));
end
```

<a id="TMP_05ec"></a>

# Plotting the Figure
```matlab
for i=1:10:N
    plot(x, cT(:,i)); % Plot the concentration at time i
    ylim([0 1]);      % Keep the y-axis steady so you see the drop
    title(['Time Step: ', num2str(i)]);
    pause(0.001);     % Short pause to create animation effect
end
```

![figure_0.png](./SpectralMethod_Diffusion_media/figure_0.png)

<a id="TMP_6d66"></a>

# Miscellany
<a id="TMP_7746"></a>

# Generating the GIF file
```matlab
% --- Optimized High-Speed GIF Generation ---
filename = 'Fast_Diffusion.gif';
h = figure('Units', 'pixels', 'Position', [100, 100, 500, 400]); % Set small fixed size
ax = axes('Parent', h);
p_handle = plot(ax, x, cT(:,1), 'LineWidth', 2); % Create the plot once
ylim([0 1]); grid on;

for i = 1:50:N % Skip more frames to speed up the "story"
    % Update the Y-data of the existing plot (MUCH faster than re-plotting)
    set(p_handle, 'YData', cT(:,i)); 
    title(ax, ['Time Step: ', num2str(i)]);
    
    drawnow; % Refresh graphics
    
    % Capture and write
    frame = getframe(h);
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im, 256);
    
    if i == 1
        imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.02); 
    else
        imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.02);
    end
end
```

![figure_1.png](./SpectralMethod_Diffusion_media/figure_1.png)

![image_0.gif](./SpectralMethod_Diffusion_media/image_0.gif)

