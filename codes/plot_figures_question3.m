%%  LAB 2 - Jesse Alves and Luis Villamarin
close all; clear all; clc;

disp('================================================') 
disp('================== QUESTION 3 ===================') 
disp('================================================') 

% %% 3.1
% 
% [x1,x2] = meshgrid(-5:0.1:5 , -5:0.1:5);
% y = 100*(x2 -x1.^2).^2 + (1 - x1).^2;
% %y = 1 + 2.*x1.*exp(-x1.^2 -x2.^2);
% 
% syms X1 X2
% f = 100*(X2 - X1^2)^2 + (1 - X1)^2
% 
% grad = gradient(f)
% hess = diff(grad)
% 
% double(subs(hess,{x1,x2}),[1,1])
% 
% return
% surf(x1,x2,y)
% axis([-2 2 -1 3 0 3000])
% grid on

%%
clear all; clc; close all

figure
f_plot =@(x1,x2) 100*(x2 - x1.^2).^2 + (1-x1).^2;

[X1,X2]=meshgrid(-2:0.001:2,-2:0.001:2);
z=f_plot(X1,X2);
contour(z,[0:1:20])
axis([500 3500 1500 4000])
grid on

% clear all
% 
% [x1,x2] = meshgrid(-2:0.1:2 , -2:0.1:2);
% y = 100*(x2 -x1.^2).^2 + (1 - x1).^2;
% 
% surfc(x1,x2,y)
% %axis([-2 2 -1 3 0 3000])
% grid on

%% Testing 
clear all; clc
syms x1 x2

f = (2*x1^2 - x2)^2 + 3*x1^2 - x2


grad = gradient(f)

grad_xk = double(subs(grad,{x1,x2},{1/2,5/4}))

%% 
[x1,x2] = meshgrid(-5:0.1:5 , -5:0.1:5);
y = (2*x1.^2 - x2).^2 + 3*x1.^2 - x2;

second = 48*x1.^2 - 8*x2 + 6;

surfc(x1,x2,second)
%axis([-2 2 -1 3 0 3000])
grid on








