function [L, U] = lugauss(A)
% FATTORIZZAZIONE LU con MEG senza pivoting [L, U] = lugauss(A)
% Calcola la matrice triangolare superiore U e trinagolare inferiore L a partire dalla matrice A 

n = size(A, 1);     % mi prendo il numero di righe (e colonne)
L = eye(n);         % matrice identità n x n
U = A;

% MEG
for k = 1:(n - 1)
    for i = (k + 1):n
        L(i, k) = U(i, k) / U(k, k);
        
        for j = k:n
            U(i, j) = U(i, j) - L(i, k)*U(k, j);
        end    
        % si potrebbe togliere il precedente ciclo for scrivendo
        % U(i, :) = U(i, :) - L(i, k)*U(k, :);
    end    
end
