%% Canonical Base
%clear all; clc

A = [2 0 -2 4 0;
       2 -4 0 -2 0;
       2 0 1 1  1];

b = [4 6 10]';

c = [2 1 -1 2 0]';


Aa = [A [1 0;0 1;0 0] b;
         zeros(1,size(A,2)) ones(1,2) 0]

factor = 1;
for ii=1:2
    Aa(end,:) = Aa(end,:) - factor*Aa(ii,:);
end


%% Pivoting Code

%% Choose the matrix and pivot
% Aa = [4 2 -1 0 1 0 12;
%           1 4 0 -1 0 1 6;
%           -5 -6 1 1 0 0 -18];
% 
% p = 2;
% q = 2;
% 
% %%
% Aa =   [3.5000         0   -1.0000    0.5000    1.0000   -0.5000    9.0000;
%            0.2500    1.0000         0   -0.2500         0    0.2500    1.5000;
%            -3.5000         0    1.0000   -0.5000         0    1.5000   -9.0000];
% 
% p = 1;
% q = 1;
% 
% %% Question 2 - Exam 2018-2019
% A = [2 0 -2 4 0;
%        2 -4 0 -2 0;
%        2 0 1 1 1];
% 
% b = [4 6 10]';
% 
% c = [2 1 -1 2 0]';
% 
% 
% nb = length(b);
% Aa = [A eye(nb) b;
%          zeros(1,size(A,2)) ones(1,nb) 0]

%%
clear all; clc
A = [0 2 4 1 0 0 0;
       1 0 4 0 1 0 0;
       1 8 8 0 0 1 0;
       4 2 8 0 0 0 1];

b = [4 6 18 24]';

c = [-1 -2 -4 0 0 0 0]';

Aa = [A b;
          c' 0]


%% PIVOTING LOOP
q = 1;
p = 2;

pivot = Aa(p,q);

%Define A_new
[N,M] = size(Aa);
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

return

%%
x0 = [0 0]';

Q = [6 2;2 4];
q = [-2 -4]

syms X1 X2
grad = [6*X1 + 2*X2 - 2;
            2*X1 + 4*X2 - 4]

grad0 = subs(grad,{X1,X2},x0')

d0 = -grad0;

a0 = -grad0'*d0/(d0'*Q*d0)

x1 = x0 + a0*d0

grad1 = Q*x1 + q'

b0 = grad1'*Q*d0/(d0'*Q*d0)

d1 = -grad1 +b0*d0

a1 = -grad1'*d1/(d1'*Q*d1)

x2 = x1 + a1*d1






