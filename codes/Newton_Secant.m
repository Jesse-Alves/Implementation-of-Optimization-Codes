%%  LAB 2 - Jesse Alves and Luis Villamarin
close all; clear all; clc;

disp('======================================================') 
disp('================== NEWTON METHOD ===================') 
disp('======================================================') 
%% General Problem Informations
syms x

% Function
f = 2*x^4 - 5*x^3 + 100*x^2 + 30*x - 75;
%f = 6*x^4 - 3*x^3 + 50*x^2 + 28*x - 63; %Other test function

% Stop Criterion
criterion = 10e-4;

% Number of iterations
num_iter_newton = 0;
num_iter_secant = 0;

%% Minimum via function
xt = [-2.5:0.000001:2.5];
ft = 2*xt.^4 - 5*xt.^3 + 100*xt.^2 + 30*xt - 75;

disp('Minimum found via numeric')
numeric_minimum = min(ft);

%% Initial Condition for Newton
x0 = 2;

%% Function Approximation 
f_dot = diff(f);
f_2dot = diff(f_dot);

%% First xk
xk = x0;

%% First Iteration
% xk+1
xk_plus_1 = xk - double(subs(f_dot,x,xk)) / double(subs(f_2dot,x,xk));

% Compute the accuracy
accuracy = abs(double(subs(f_dot,x,xk)));
%accuracy = abs(xk_plus_1 - xk) %Other stop condition
%% Newton Loop
while accuracy > criterion
    % Update the xk
    xk = xk_plus_1;

    % xk+1
    xk_plus_1 = xk - double(subs(f_dot,x,xk)) / double(subs(f_2dot,x,xk));

    % Compute the accuracy
    accuracy = abs(double(subs(f_dot,x,xk)));
    num_iter_newton = num_iter_newton +1;
end

%% Display results
disp('The minimum x: ')
x_min = xk

disp('The function value: ')
f_min = double(subs(f,x,x_min))

disp('The number of iterations: ')
num_iter_newton

disp('Accuracy of Newton Method')
acc = abs(numeric_minimum - f_min)

%% Plot results
xt = [-2.5:0.01:2.5];
y = 2.*xt.^4 -5.*xt.^3+100.*xt.^2+30.*xt-75;

plot(xt,y,'LineWidth',2)
grid on
hold on
plot(x_min,f_min,'r*','LineWidth',5)

legend('Problem Function','Minimum Point','FontSize',12)
xlabel('x','FontSize',16)
ylabel('f(x)','FontSize',16)
title('Newton Method','FontSize',16)

%% 
disp('======================================================') 
disp('================== SECANT METHOD ===================') 
disp('======================================================') 

%% Initial Condition for Secant
x0 = 2.1;
x1 = 2.0;

%% Function Approximation 
f_dot = diff(f);

%% First xk-1 and xk
xk_minus_1 = x0;
xk = x1;

%% First Iteration

% Compute xk+1
xk_plus_1 = xk - ((xk - xk_minus_1)/(double(subs(f_dot,x,xk))  ...
    - double(subs(f_dot,x,xk_minus_1))))*double(subs(f_dot,x,xk));    

% Compute the accuracy
accuracy = abs(double(subs(f_dot,x,xk)));
%accuracy = abs(xk_plus_1 - xk) %Other stop condition
%% Newton Loop
while accuracy > criterion
    
    % Update the xk-1 and xk
    xk_minus_1 = xk;
    xk = xk_plus_1;

    % Compute xk+1
    xk_plus_1 = xk - ((xk - xk_minus_1)/(double(subs(f_dot,x,xk))  ...
        - double(subs(f_dot,x,xk_minus_1))))*double(subs(f_dot,x,xk)) ;

    % Compute the accuracy
    accuracy = abs(double(subs(f_dot,x,xk)));

    num_iter_secant = num_iter_secant +1;
end

%% Display results
disp('The minimum x: ')
x_min = xk

disp('The function value: ')
f_min = double(subs(f,x,x_min))

disp('The number of iterations: ')
num_iter_secant

disp('Accuracy of Secant Method')
acc = abs(numeric_minimum - f_min)

%% Plot results
figure
plot(xt,y,'LineWidth',2)
grid on
hold on
plot(x_min,f_min,'g*','LineWidth',5)

legend('Problem Function','Minimum Point','FontSize',12)
xlabel('x','FontSize',16)
ylabel('f(x)','FontSize',16)
title('Secant Method','FontSize',16)
