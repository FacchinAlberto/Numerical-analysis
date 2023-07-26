function t = interpol(x, y, s)
% INTERPOLAZIONE POLINOMIALE t = interpol(x, y, s)
% Calcola il polinomio di interpolazione sui punti (x, y) 
% restituisce i valori dell'interpolante nei nodi s
% Usa polyfit e polyval 
m = length(x) - 1;        % grado del polinomio di interpolazione = npunti - 1
coeff = polyfit(x, y, m); % coeff: coefficienti del pol. interpolante 
t = polyval(coeff, s);   % valutazione del polinomio sul vettore s
