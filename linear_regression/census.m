%-------------------------------------------------------------------------
% SCRIPT per modellizare la crescita della popolazione degli 
% Stati Uniti di America. 
% A partire da misurazioni del numero di abitanti negli anni 
% dal 1900 al 2000.
% A partire da questi dati si vuole estimare il numero di abitanti
% nell'anno 2010, e confrontarlo con il valore rilevato nel censimento
% effettuato in tale anno che era di 308.745.538 abitanti.
%-------------------------------------------------------------------------
% anni in cui sono stati effettuate le misurazioni
x = 1900:10:2000;   % equivalente a:    x = [1900 1910 1920 1930 1940 1950 1960 1970 1980 1990 2000]
% Dati in milioni di abitanti
y = [75.995 91.972  105.711  123.203 131.669 150.697 179.323 203.212 226.505 249.633 281.422];
yvero = 308.745; % milioni di abitanti
xestrap = 2010;


% Polinomio di approssimazione ai minimi quadrati di grado 1 (RETTA) 
a1 = polyfit(x, y, 1);  % calcola i coeff. della retta
xx = linspace(x(1), xestrap);   % crea 100 punti tra x(1) = 1900 e xestrap = 2010
yy1 = polyval(a1, xx);
err1vec = (polyval(a1, x) - y).^2;  % calcola le differenze tra i valori della retta ed i valori veri nei punti x
err1 = sqrt(sum(err1vec));           % somma di tutti gli errori
% norm(polyval(a1, x) - y)      % comando alternativo per calcolare err1
prevrettaMQ = polyval(a1, xestrap);  % calcola il valore della retta nel punto xestrap = 2010
fprintf('\n [GRADO] %d \n [ERRORE]: %e \t [PREVISIONE]: %f \t [VALORE REALE]: %f', 1, err1, prevrettaMQ, yvero);
fprintf('\n [COEFFICIENTI] \t [a0]: %f \t [a1]: %f', a1(1), a1(2));


% Polinomio di approssimazione ai minimi quadrati di grado 2 (PARABOLA)
a2 = polyfit(x, y, 2);  % calcola i coeff. della parabola
% xx = linspace(x(1), xestrap);   % crea 100 punti tra x(1) = 1900 e xestrap = 2010
yy2 = polyval(a2, xx);
err2vec = (polyval(a2, x) - y).^2;      % calcola le differenze tra i valori della parabola ed i valori veri nei punti x
err2 = sqrt(sum(err2vec));               % somma di tutti gli errori
% norm(polyval(a2, x) - y)        % comando alternativo per calcolare err2
prevparab = polyval(a2, xestrap);     % calcola il valore della parabola nel punto xestrap = 2010
fprintf('\n\n [GRADO] %d \n [ERRORE]: %2.2e \t [PREVISIONE]: %f \t [VALORE REALE]: %f', 2, err2, prevparab, yvero);
fprintf('\n [COEFFICIENTI] \t [a0]: %f \t [a1]: %f \t [a2]: %f', a2(1), a2(2), a2(3));
fprintf('\n\n');


% GRAFICO
plot(x, y, 'mo', 'markersize', 6);
hold on;
plot(xx, yy1, 'b-', 'Linewidth', 2); % retta di approssimazione ai minimi quadrati
plot(xx, yy2, 'r-', 'Linewidth', 2); % parabola min. quadrati
plot(xestrap, yvero, 'g*', 'markersize', 10); % punto vero
legend('punti', 'retta MQ', 'parabola MQ', 'valore vero', 'Location', 'northwest');     % ('Location', 'northwest') serve per mettere la legenda in alto a sx
hold off;