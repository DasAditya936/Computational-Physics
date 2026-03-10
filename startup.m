% startup.m - Aditya's Physics Portal Configuration

% JOB 1: Add the main directory to MATLAB's search path 
% Ensures cpsync() works even when you are deep in Topics/04/code/
addpath('/home/adityadas/codingProjects/MATLAB_CodeScripts');

% JOB 2: Define the cpsync function handle with the System Library Fix
% 'LD_LIBRARY_PATH=' clears MATLAB's old internal libraries 
% so it can use Debian's modern Git/SSH/SSL without "symbol lookup" errors.
cpsync = @() system('LD_LIBRARY_PATH= /home/adityadas/codingProjects/MATLAB_CodeScripts/sync.sh');

% JOB 3: Status confirmation on startup
fprintf('🚀 Physics Portal Active: Type cpsync() to sync with GitHub\n');

