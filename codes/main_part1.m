%% Main file to test Optimization Functions
clear all; close all; clc
% Jesse Alves and Luis Villamarin

%% 1 Question 

disp('======================================================') 
disp('==================== BFS METHOD ======================') 
disp('======================================================') 

% Test values
A = [1 5 1 0 0; 
       2 1 0 1 0; 
       1 1 0 0 1];

b = [40 20 12]';
c = [-3 -5 0 0 0]'; 

[f,x,B] = Exhaustive_LP(A,b,c);

%% 2 Question 
disp('======================================================') 
disp('================= SIMPLEX METHOD =====================') 
disp('======================================================') 

v = [3 4 5];
[f,x,B] = LP_Simplex(A,b,c,v);

%% 3 Question 
disp('======================================================') 
disp('============= TWO-PHASE SIMPLEX METHOD ==============') 
disp('======================================================') 

% 2x4 Slide 45  
A = [4 2 -1 0;1 4 0 -1];
b = [12 6]';
c = [2 3 0 0 0]';

[f,x,B] = LP_Two_Phase_Simplex(A,b,c)





