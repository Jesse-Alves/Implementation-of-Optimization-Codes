%%  LAB 2 - Jesse Alves and Luis Villamarin
close all; clear all; clc;

disp('======================================================') 
disp('================== RANK THE METHODS ==================') 
disp('======================================================') 

%%  Computing the condition number of Q

%% Case 1
lambda = abs(rand());

cond_num1 = lambda/lambda

%% Case 2
lambda_max = 10;
lambda_min = 1;

cond_num2 = lambda_max/lambda_min

%% Case 3
lambda_max = 2;
lambda_min = 1;

cond_num3 = lambda_max/lambda_min

disp('=========== Clearly the rank, from faster to slower, is : ===========')
disp('Rank 1 = Case 1')
disp('Rank 2 = Case 3')
disp('Rank 3 = Case 2')

disp(' '); disp(' '); disp(' ')
%%
disp('======================================================') 
disp('=============== ROUTINE IMPLEMENTATION ===============') 
disp('======================================================') 

%% General Parameters
e1 = 10e-4;

%%
disp(' '); disp(' '); disp(' ')
disp('======================= CASE 1 ========================') 

% Problem Parameters
lambda = abs(rand());
Q = [lambda 0;
        0 lambda];

q = rand(2,1);
x0 = rand(2,1);
title_graph = 'Case 1';

[x_real_min, x_min, f_min, accuracy, iter] = steepest_quad(Q,q,x0,e1,title_graph);
%%
disp(' '); disp(' '); disp(' ')
disp('======================= CASE 2 ========================') 

% Problem Parameters
Q = [10 0;0 1];
q = [-3 -3]';
x0 = [-2 -7]';
title_graph = 'Case 2';

[x_real_min, x_min, f_min, accuracy, iter] = steepest_quad(Q,q,x0,e1,title_graph);
%%
disp(' '); disp(' '); disp(' ')
disp('======================= CASE 3 ========================') 

% Problem Parameters
Q = [2 0;0 1];
q = [-3 -3]';
x0 = [-2 -7]';
title_graph = 'Case 3';

[x_real_min, x_min, f_min, accuracy, iter] = steepest_quad(Q,q,x0,e1,title_graph);

%% The Steepest Quadratic Function
function [x_real_min, x_min, f_min, accuracy, iter] = steepest_quad(Q,q,x0,e1,title_graph)
    %% First Iteration
    xk = x0;
    
    % Gradient
    grad_xk = Q*xk + q;
    
    % ak
    ak = (grad_xk'*grad_xk)/(grad_xk'*Q*grad_xk);
    
    %xk+1
    xk_plus_1 = xk - ak*grad_xk;
    
    % Compute the accuracy
    accuracy = norm(xk_plus_1 - xk)/norm(xk);
    
    % Storage the xks
    count = 1;
    iter{count} = xk;
    %% Steepest Descent Loop
    while accuracy > e1
        % Update the xk
        xk = xk_plus_1;
        
        % Storage the xks
        count = count + 1;
        iter{count} = xk;
    
        % Gradient
        grad_xk = Q*xk + q;
        
        % ak
        ak = (grad_xk'*grad_xk)/(grad_xk'*Q*grad_xk);
        
        %xk+1
        xk_plus_1 = xk - ak*grad_xk;
        
        % Compute the accuracy
        accuracy = norm(xk_plus_1 - xk)/norm(xk);
    end
    
    %% Display results
    disp('Real minimum: ')
    x_real_min = -inv(Q)*q
    
    disp('The minimum x: ')
    x_min = xk
    
    disp('The function value: ')
    f_min = 0.5*xk'*Q*xk + q'*xk
    
    disp('The accuracy: ')
    accuracy

    %% Plot the iterations
    figure
    for ii=1:length(iter)-1
            % Arrow length
            arrow_vector = iter{ii+1} - iter{ii};

            % Plot arrows
            quiver(iter{ii}(1),iter{ii}(2), arrow_vector(1), arrow_vector(2), 0, 'LineWidth', 2);
            hold on
    end
    xlabel('x1','FontSize',22)
    ylabel('x2','FontSize',22)
    title(title_graph,'FontSize',22)
    grid on
end
