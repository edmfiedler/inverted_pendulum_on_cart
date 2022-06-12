clear
clc
close all

%% Load state-space system
State_space

%% Obtain LQR controller

% Augment the existing system
Ad_a = [Ad zeros(size(Ad,1),1); -ts*Cd(1,:) 1];
Bd_a = [Bd;zeros(1,1)];

Q = [200 0 0 0 0; 
     0 1 0 0 0; 
     0 0 200 0 0;
     0 0 0 1 0;
     0 0 0 0 1000];

R = 1;

K = dlqr(Ad_a,Bd_a,Q,R);

Kx = K(1:end-1); Ki = -K(end);