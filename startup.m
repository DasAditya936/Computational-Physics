% startup.m
% This creates a MATLAB command that runs your Debian sync script
cpsync = @() system('/home/adityadas/codingProjects/MATLAB_CodeScripts/sync.sh');

