%%  LAB 1 - Jesse Alves and Luis Villamarin

%% ======================================================
%% =========== EXHAUSTIVE LINEAR PROGRAMING ============
%% ======================================================

function [f,x,B] = Exhaustive_LP(A,b,c)
%clear all; close all; clc

%     %% Test values
%     A = [1 5 1 0 0; 
%          2 1 0 1 0; 
%          1 1 0 0 1];
%     
%     b = [40 20 12]';
%     c = [-3 -5 0 0 0]';
    
    %% Initial variables
    optimal_cost = inf;
    
    %% Get information for the loop
    [m,n] = size(A);
    num_vector = 1:1:n;
    num_eq = length(b);
    
    %% Computing the number of possible solitions
    C = nchoosek(num_vector,num_eq); %The matrix with all possible combinations
    iter = length(C);
    
    %% A loop to find every basic feasible solitions
    for k = 1:iter
        
        % Basis Matrix
        B_list{k} = A(:,[C(k,:)]);
        
        %% Check if B is a inversive matrix
        if det(B_list{k}) ~= 0
    
            % Find xb
            xb{k} = inv(B_list{k})*b;
        
            % Construct x with xb and zeros ---------
            x_temp = zeros(1,length(A));
            j = 1;
            for vec_pos = C(k,:)
                x_temp(vec_pos) = xb{k}(j);
                j = j + 1;
            end    
            x_list{k} = x_temp';
            % -------------------------------------------------
            
            %% Check if there is some negative values in x vector
            if not(any(x_list{k}<0))
    
                % Find the Optimal solution min c^T*x
                cost_function = c'*x_list{k};
                
                if cost_function < optimal_cost
                    optimal_cost = cost_function;
                    optimal_BFS = x_list{k};
                    optimal_basis = B_list{k};            
                end        
            end
        end
    end
    
    %% Checking if the function found an optimal cost
    if optimal_cost == inf
        msg1 = strcat('The function did not find any minimum in basic feasible solution!');
        msgbox(msg1)
        f=[];
        x=[];
        B=[];
    else
        disp('The Optimal Best Feasible Solution is: ')
        x = optimal_BFS
    
        disp('The Optimal Cost is: ')
        f = optimal_cost
        
        disp('The Basis is: ')
        B = optimal_basis

        disp('The number of iterations was:')
        iterations = k
    end
end