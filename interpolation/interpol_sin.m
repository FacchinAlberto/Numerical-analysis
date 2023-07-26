%--------------------------------------------------------%
%interpolazione polinomiale della funzione seno in [-5,5]
%--------------------------------------------------------%
n = 6; % numero di punti
a = -5; b = 5;

% creazione di n nodi equispaziati in [a,b]
x  = linspace(a,b,n);
h = (b - a)/(n - 1);
x  = a:h:b;
% ordinate dei nodi di interpolazione 
y = sin(x);


% creazione dei punti dove valutare il polinomio in [a,b]
m = 101;
xval = linspace(a, b ,m);

% Calcolo e valutazione dell'interpolante
yval = interpol(x, y, xval);

% Creazione del grafico di confronto (seno versus interpolante)
clf;
plot(xval, sin(xval), 'b-', 'linewidth', 2);
hold on;
plot(xval, yval, 'r-', 'linewidth', 2);
%plot(xval, sin(xval), 'b-', xval, yval, 'r-');
plot(x, y, 'ko');
hold off;
title('Sin(x) e il suo interpolante polinomiale di grado 5');
legend('sin(x)', 'Interpolante','punti')
