function [x, w, Itrap] = trapezi(a, b, f)
% FORMULA DEI TRAPEZI SEMPLICE.

% INPUT:
% a, b: ESTREMI DI INTEGRAZIONE.
% f:    FUNZIONE INTEGRANDA
% OUTPUT:
% x:     NODI INTEGRAZIONE.
% w:     PESI INTEGRAZIONE.
% Itrap: VALORE APPROSSIMATO CALCOLATO CON LA FORMULA DI QUADRATURA 

N = 1;
h = (b - a)/N;             % PASSO INTEGRAZIONE.
x = a:h:b; x = x';         % NODI INTEGRAZIONE.
w = ones(N + 1, 1);         % PESI INTEGRAZIONE.
w(1) = 0.5; w(N + 1) = 0.5;
w = w*h;
fx = feval(f, x);         %VALUTAZIONE DELLA FUNZIONE NEI NODI 
Itrap = w'*fx;           %CALCOLO DEL VALORE APPROSSIMATO DALLA FORMULA