%%  Jesse Alves and Luis Villamarin
function [f,x,B] = LP_Two_Phase_Simplex(A,b,c)
% clear all; clc;

% Test values
%% 3x5 Solution Q5 Exercises
% A = [1 0 -1 0 0; 1 -1 0 -2 0; 2 0 0 1 1];
% b = [3 1 7]';
% c = [2 0 0 0 0]';


%% Obtain dimentions
[n,m] = size(A);
b_size = length(b);

%% Minimizer of y1+y2
%Create C vector 
C = [zeros(1,m), ones(1,2) 0];
if n == 2
    ad = eye(2) ;
else
ad = [eye(2) ; zeros(1,n-1)];
end
Aa = [A  ad b ;  C ];
[N,M] = size(Aa);

% Substract the new base to get the Canonical tableau
if n == 2
   Ca = ((-Aa(1,:) + Aa(end,:)) - (Aa(2,:) + Aa(end,:)));
   Ca(end,5) =0;
   Ca(end,6) =0 ;
else
Ca = ((-Aa(1,:) + Aa(end,:)) - (Aa(2,:) + Aa(end,:))) ;
end

Aa = [Aa(1:n,:) ; Ca ];
%% Phase one
pp = [];
while min(Aa(end,:)) < 0
for hh = 1:N

% Finding pivot
q = find(Aa(end,1:end-1) == min(Aa(end,1:end-1)));
condition = (min(Aa(1:end-1,end)./Aa(1:end-1,q))> 0);
argmin = Aa(1:end-1,end)./Aa(1:end-1,q);

if condition == 0  % check if there are any positive elements
    condition = argmin(Aa(1:end-1,end)./Aa(1:end-1,q) > 0);
    positive_min = min(argmin(condition)); % find positive minimum
    p = find(Aa(1:end-1,end)./Aa(1:end-1,q) == positive_min, 1, 'first'); % find index of first element that equals positive minimum
    
else
    positive_min = min(argmin);
p  = find(argmin == positive_min, 1, 'first'); 
end

pivot = Aa(p,q); 

if  p ~= hh
row_to_reduce = hh; 
factor = Aa(row_to_reduce,q) / pivot;  % factor to multiply pivot row by

Aa(row_to_reduce,:) = Aa(row_to_reduce,:) - factor * Aa(p,:);

end
end
if pivot > 1
   factor = 1 / pivot;  % factor to multiply pivot row by
   Aa(p,:) = Aa(p,:) * factor;
end 
end
% Extract the base
counter = 1;
for pp =  1:M
   
    if sum(Aa(1:end-1,pp)) == 1 && sum(find(Aa(1:end-1,pp) == 0)) >= 1 
    B(counter) = pp;
    end
     counter = counter+1;
end

B= nonzeros(B)';

%% Phase Two

% New Canonical
if n > 2
Aa = [Aa(1:end-1,1:m), Aa(1:end-1,end) ; c' 0];
else 
    Aa = [Aa(1:end-1,1:m), Aa(1:end-1,end) ; c'];
end
[Nn,Mm] = size(Aa);
Cc = find(Aa(end,:) ~=0 );

    for iter= 1:length(Cc)

        Aa(end,:) = -Aa(end,Cc(iter))*Aa(find(Aa(:,Cc(iter)) ==1),:) + Aa(end,:);
       
    end
%% organising the solution vector 
x = zeros(1,Mm-1);
for ii = 1:Nn
    for jj = 1:Mm-1
        if Aa(ii,jj)==1 && sum(Aa(1:end-1,jj) == 0)>= 1 
            x(jj) = Aa(ii,end);
        end
    end
end
x= x';
f= Aa(end,end);
B = Cc;
