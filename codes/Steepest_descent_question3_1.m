%%  LAB 2 - Jesse Alves and Luis Villamarin
close all; clear all; clc;

disp('======================================================') 
disp('============== STEEPEST DESCENT METHOD ==============') 
disp('======================================================') 

%% General Problem Informations
syms x1 x2 alpha

% Function
f = 100*(x2 - x1^2)^2 + (1-x1)^2;    

% Stop Criterion
e1 = 10e-3;
e2 = 10e-4;

%% Initial Condition
x0 = [-1 2]';
a0 = 0.1;

%% First xk and ak
xk = x0;
ak = a0;

%% Gradient function and Hessian matrix
grad = sym2cell(gradient(f));
%xQ = sym2cell(hessian(f));

%% First Iteration
% Gradient of f(.) in point xk
grad_xk = double(subs(grad,{x1,x2},{xk(1),xk(2)}));
%Qk = double(subs(Q,{x1,x2},{xk(1),xk(2)}));

% xk+1
xk_plus_1 = xk - ak*grad_xk;

% Compute the accuracy
accuracy = norm(xk_plus_1 - xk)/norm(xk);


%% Steepest Descent Loop
while accuracy > e1
    % Update the xk
    xk = xk_plus_1;

    % Gradient of f(.) in point xk
    grad_xk = double(subs(grad,{x1,x2},{xk(1),xk(2)}));
    %Qk = double(subs(Q,{x1,x2},{xk(1),xk(2)}));
    
    % Find the optimal alpha
    arg = xk - alpha*grad_xk;
    
    h = subs(f,{x1,x2},{arg(1),arg(2)});

    ak = argmin_ak(h, alpha, ak, e2);
    %ak = (grad_xk'*grad_xk)/(grad_xk'*Qk*grad_xk);

    % xk+1
    xk_plus_1 = xk - ak*grad_xk;
    
    % Compute the accuracy
    accuracy = norm(xk_plus_1 - xk)/norm(xk);

end

%% Display results
disp('The minimum x: ')
x_min = xk

disp('The function value: ')
f_min = double(subs(f,{x1,x2},{x_min(1),x_min(2)}))

disp('The accuracy: ')
accuracy


%% Plot results
figure
f_plot =@(x1,x2) 100*(x2 - x1.^2).^2 + (1-x1).^2;

[X1,X2]=meshgrid(-2:0.001:2,-2:0.001:2);
z=f_plot(X1,X2);

%contour(z,[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 15 20])
contour(z,[0:1:20])
axis([500 3500 1500 4000])
grid on

xlabel('x1','FontSize',16)
ylabel('x2','FontSize',16)
title('Level Set of Rosenbrock’s function','FontSize',16)
%%
% xt = [-2.5:0.01:2.5];
% y = 2.*xt.^4 -5.*xt.^3+100.*xt.^2+30.*xt-75;
% 
% plot(xt,y,'LineWidth',2)
% grid on
% hold on
% plot(x_min,f_min,'r*','LineWidth',5)
% 









%% Newton Method Function
function ak_plus_1 = argmin_ak(h, alpha, ak, e2)
    
% Function Approximation 
h_dot = diff(h);
h_2dot = diff(h_dot);

% First Iteration
% ak+1
ak_plus_1 = ak - double(subs(h_dot,alpha,ak)) / double(subs(h_2dot,alpha,ak));

% Compute the accuracy
accuracy = abs(ak_plus_1 - ak)/ak;

% Newton Loop
while accuracy > e2
    % Update the ak
    ak = ak_plus_1;

    % ak+1
    ak_plus_1 = ak - double(subs(h_dot,alpha,ak)) / double(subs(h_2dot,alpha,ak));

    % Compute the accuracy
    accuracy = abs(ak_plus_1 - ak)/ak;
end
end

