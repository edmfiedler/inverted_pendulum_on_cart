clear
clc

%% Load parameters
Parameters

%% Define continuous system

A = [0 1 0 0;
    0 0 m*g/M 0;
    0 0 0 1;
    0 0 (m+M)*g/(l*M) 0];

B = [0; 1/M; 0; 1/(l*M)];

C = [1 0 0 0;
     0 0 1 0];

D = 0;

csys = ss(A,B,C,D);

%% Obtain the discretised system

ts = 1e-3;

dsys = c2d(csys,ts);

Ad = dsys.A; Bd = dsys.B; Cd = dsys.C; Dd = dsys.D;