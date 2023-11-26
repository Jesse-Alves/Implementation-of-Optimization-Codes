%% Golden Section 2.1  M1 HealthTech - Luis Villamarin & Jesse Alves

%% Initialization
clear all;
close all;
clc;
%% Define parameters

e = 0.01;
iter = 50;
ro = (3 - sqrt(5))/2;
min = -2;
max = 2;
X=min:0.1:max;
count = 1;
x1 = min+ro*(max-min);
x2 = max-ro*(max-min);

%% Starting the loop to find minimum

while (count < iter && (abs(max-min) > e) ) 
   
    if (f(x1)<f(x2))
        max = x2;
        x2 = x1;
        x1=min+ro*(max-min);
        
    else 
        min = x1;
        x1=x2;
        x2 =max-ro*(max-min);
    end 
 count=count+1;
end

%% Plotting

animatedline(X,f(X));
hold on;
plot(x1,f(x1),'-x','Color','r');
fun = '$f(x) = x^4 + 4x^3 + 9x^2 + 6x + 6$';
title( 'Golden section for:', fun , 'interpreter','latex','FontSize',22)
xlabel('x','FontSize',22)
ylabel('f(x)','FontSize',22)
grid on

%% Definition of the function to minimize

function [output] = f(x)
output = x.^4 + 4*x.^3 + 9*x.^2 + 6*x + 6;
end
