function [x, w, Isimp] = simpson(a, b, f)
% FORMULA DI CAVALIERI-SIMPSON SEMPLICE.

% INPUT:
% a, b: ESTREMI DI INTEGRAZIONE.
% f:    FUNZIONE INTEGRANDA
% OUTPUT:
% x:     NODI INTEGRAZIONE.
% w:     PESI INTEGRAZIONE.
% Isimp: VALORE APPROSSIMATO CALCOLATO CON LA FORMULA DI QUADRATURA 

N = 1;
h = (b - a)/N;             % PASSO INTEGRAZIONE.
x = [];
for i = 0:1:(2*N)
    xnew = a + (i*h/2);
    x = [x; xnew];     % NODI INTEGRAZIONE.
end
%x = x';
w = ones(2*N + 1, 1);         % PESI INTEGRAZIONE.
w(2:2:(2*N), 1) = 4;
w(3:2:(2*N - 1), 1) = 2;
w = w*h/6;
fx = feval(f, x);         %VALUTAZIONE DELLA FUNZIONE NEI NODI 
Isimp = w'*fx;           %CALCOLO DEL VALORE APPROSSIMATO DALLA FORMULA