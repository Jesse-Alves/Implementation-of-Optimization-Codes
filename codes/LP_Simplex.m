%%  LAB 1 - Jesse Alves and Luis Villamarin

%% ======================================================
%% ================ THE SIMPLEX METHOD ==================
%% ======================================================

%% Test values
%clear all; clc;
% A = [1 5 1 0 0; 
%        2 1 0 1 0; 
%        1 1 0 0 1];
% 
% b = [40 20 12]';
% c = [-3 -5 0 0 0]';
% v = [3 4 5];

function [f,x,B] = LP_Simplex(A,b,c,v)
%% Obtain dimentions
[n,m] = size(A);
b_size = length(b);

%% Create A augmented 
Aa = [A b;c' 0];
[N,M] = size(Aa);

% Number of possible iterations
iter = nchoosek(m,b_size);

for k = 1:iter   
    % Basis
    B = Aa(1:end-1,[v]);
    
    % Chosing the r index
    r_index = find(Aa(N,1:end-1)~=0);

    %% Finding the r
    ii = 1;
    for i=r_index
        y_temp = Aa(1:end-1,i);
        c_temp = c([v])   
    
        r(ii) = c(i) - (c_temp')*y_temp;
        ii = ii+1;
    end
    r
    %% Check if the minimizer was found
    if any(r<0) 
        q = find(r == min(r));    
        y_iq =  Aa(1:end-1,q);
    
        if any(y_iq > 0)              
            %% Pivoting about the [p q]th element

            % Finding the pivot
            piv = Aa(1:end-1,end) ./ y_iq;

            % Checking if there is some piv negative
            if any(piv<0)
                piv(find(piv<0)) = inf;                
            end
            
            p = find(piv == min(piv));
            pivot = Aa(p,q);

            %Define A_new
            Aa_new = zeros(N,M);
            
            for linha = 1 : N
                for coluna = 1 : M
                    if linha ~= p
                        Aa_new(linha,coluna) = Aa(linha,coluna) - (Aa(linha,q)/pivot)*Aa(p,coluna); %Aa(p,q)
                    else
                        Aa_new(linha,coluna) = Aa(linha,coluna)/pivot; %Aa(p,q)
                    end
                end
            end
            
            % Update the 
            Aa = Aa_new

            % Update v     
            v(p) = q;

           % Find x
            x = zeros(1,m);
            x([v]) = Aa(1:b_size,M);
    
            % Find f
            f = -Aa(N,M);      
        else
            % Stop, the problem is unbounded!!
            disp('Error - the problem is unbounded')
            return
        end
    else
        %Stop, because I found the minimizer
        B = v
        f = -Aa(N,M)
        x([v]) = Aa(1:b_size,M)      
        
        disp('The number of iterations was:')
        iterations = k
        return
    end
end

end