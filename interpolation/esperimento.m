clear all; clc;
% DEFINIZIONE DELLA FUNZIONE DI RUNGE
runge = @(x) 1./(x.^2 + 1);

fid = fopen('errorerunge.ris', 'w');
warning('off','all');   % disattivo momentaneamente i warnings

a = -5;
b = 5;
n = 31;     % grado "finale"

for k = 1:n
    x = (a):(b - a) / k:5;
    y = runge(x);   % valutazione della funzione di runge in x(k)
    s = (a):(b - a) / (10*k):5;   % nodi test (dove valutare l'interpolante)
    
    xgcl = chebgausslob(a, b, k+1);  % nodi Gauss-Chebyshev-Lobatto
    ygcl = runge(xgcl);
    
    % CALCOLO E VALUTAZIONE DELL'INTERPOLANTE
    t = interpol(x, y, s);
    tt = interpol(xgcl, ygcl, s); 
    

    % CALCOLO E SCRITTURA A VIDEO DEGLI ERRORI ASSOLUTI (in norma infinito).
    % la norma infinito di un vettore e' la massima componente in valore assoluto.
    ee = norm(runge(s)-t, inf);
    ec = norm(runge(s)-tt, inf); 
    fprintf('\n [GRADO] %3d \n [ERR. (NORM INF.)] \t [EQS]:%2.2e \t [GCL]:%2.2e', k, ee, ec);
    fprintf('\n');

    % scrittura su file
    fprintf(fid, '\n [GRADO] %3d \n [ERR. (NORM INF.)] \t [EQS]:%2.2e \t [GCL]:%2.2e', k, ee, ec);
    fprintf(fid, '\n');

    
    % INSERISCO DI SEGUITO LA FUNZIONE DI PLOTTAGGIO NEL FOR COSI' IL GRAFICO SI AGGIORNA AD OGNI ITERAZIONE
    
    % PLOT INTERPOLANTE VS FUNZIONE DI RUNGE.
    f1 = figure(1);
    f1.Position(1:2) = [100, 250];  % parametri per settare la posizione di dove appare il grafico nello schermo
    plot(s, runge(s), s, t, s, tt);  
    legend('F. Runge', 'I. nodi equis', 'I. nodi GCL')
    str = sprintf(' Grado %d', k);
    title(str) 

    %PLOT errore
    f2 = figure(2);
    f2.Position(1:2) = [800, 250];  % parametri per settare la posizione di dove appare il grafico nello schermo
    plot(s, runge(s)-t, s, runge(s)-tt);  
    legend('Errore nodi equis', 'Errore nodi GCL')
    title(str)
    
    pause(1.0)  % funzione per creare intervalli di tempo tra un'iterazione e la successiva, quindi tra un plot e l'altro
end

fclose(fid);
warning('on','all');    % riattivo i warnings


% Alla luce dei risultati si dica se c'è convergenza di pn a 1 / (1 + x^2), al crescere di
% n, qualora si utilizzino nodi equispaziati e qualora si utilizzino nodi di
% Gauss-Chebyshev-Lobatto.

% Come emerge dai grafici e dai risultati che si ottengono in errorerunge.ris, 
% qualora si utilizzino nodi equispaziati, si verifica il fenomeno di Runge, 
% ovvero si ha che, al crescere del numero di nodi, cresce anche l'errore, 
% quindi non vi è covergenza di pn alla funzione di Runge.
% Questo fenomeno non si verifica, invece, se vengono utilizzati nodi di
% Chebyshev, in questo caso di Chebyshev-Gauss-Lobatto.
% Infatti, per il teorema di Bernstein, essendo 1 / (1 + x^2) di classe 
% C infinito, l'errore tende a 0 al crescere del numero di nodi, di
% conseguenza vi è convergenza alla funzione di Runge.