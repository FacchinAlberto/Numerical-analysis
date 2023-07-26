%-------------------------------------------------------------------------
% SCRIPT per modellizare il legame tra lo sforzo e la relativa deformazione
% di un tessuto biologico (un disco invertebrale).
% Si vuole stimare la deformazione epsilon corrispondente ad uno sforzo
% sigma = 0.7 MPa
%-------------------------------------------------------------------------
% anni in cui sono stati effettuate le misurazioni
sigma = [0 0.06 0.14 0.25 0.31 0.47 0.60];  % sigma è la x
% Dati in milioni di abitanti
epsilon = [0 0.08 0.14 0.20 0.23 0.25 0.28];    % epsilon è la y
epsilon_vero = 0.29; % valore osservato per sigma = 0.7
sigma_estrap = 0.7;


% Polinomio di approssimazione ai minimi quadrati di grado 1 (RETTA) 
a1 = polyfit(sigma, epsilon, 1);  % calcola i coeff. della retta
xx = linspace(sigma(1), sigma_estrap);   % crea 100 punti tra x(1) = 0 e sigma_estrap = 0.7
yy1 = polyval(a1, xx);
err1vec = (polyval(a1, sigma) - epsilon).^2;  % calcola le differenze tra i valori della retta ed i valori veri nei punti sigma
err1 = sqrt(sum(err1vec));           % somma di tutti gli errori
% norm(polyval(a1, sigma) - epsilon)      % comando alternativo per calcolare err1
prevrettaMQ = polyval(a1, sigma_estrap);  % calcola il valore della retta nel punto sigma_estrap = 0.7
fprintf('\n [GRADO] %d \n [ERRORE]: %e \t [PREVISIONE]: %f \t [VALORE REALE]: %f', 1, err1, prevrettaMQ, epsilon_vero);
fprintf('\n [COEFFICIENTI] \t [a0]: %f \t [a1]: %f', a1(1), a1(2));


% Polinomio di approssimazione ai minimi quadrati di grado 2 (PARABOLA)
a2 = polyfit(sigma, epsilon, 2);  % calcola i coeff. della parabola
% xx = linspace(x(1), xestrap);   % crea 100 punti tra x(1) = 0 e sigma_estrap = 0.7
yy2 = polyval(a2, xx);
err2vec = (polyval(a2, sigma) - epsilon).^2;      % calcola le differenze tra i valori della parabola ed i valori veri nei punti sigma
err2 = sqrt(sum(err2vec));               % somma di tutti gli errori
% norm(polyval(a2, sigma) - epsilon)        % comando alternativo per calcolare err2
prevparab = polyval(a2, sigma_estrap);     % calcola il valore della parabola nel punto sigma_estrap = 0.7
fprintf('\n\n [GRADO] %d \n [ERRORE]: %2.2e \t [PREVISIONE]: %f \t [VALORE REALE]: %f', 2, err2, prevparab, epsilon_vero);
fprintf('\n [COEFFICIENTI] \t [a0]: %f \t [a1]: %f \t [a2]: %f', a2(1), a2(2), a2(3));
fprintf('\n');


% Calcolo del polinomio di interpolazione che passa per i punti (sigma, epsilon)
t = interpol(sigma, epsilon, xx);
previnterpol = t(size(t, 2));
fprintf('\n [INTERPOLANTE] \n [PREVISIONE]: %f \t [VALORE REALE]: %f', previnterpol, epsilon_vero);
fprintf('\n\n');


% GRAFICO
plot(sigma, epsilon, 'ko', 'markersize', 6);
hold on;
plot(xx, yy1, 'b-', 'Linewidth', 2); % retta di approssimazione ai minimi quadrati
plot(xx, yy2, 'r-', 'Linewidth', 2); % parabola min. quadrati
plot(sigma_estrap, epsilon_vero, 'g*', 'markersize', 10); % punto vero

plot(xx, t, 'm-', 'Linewidth', 1); % interpolante

legend('punti', 'retta MQ', 'parabola MQ', 'valore vero', 'interpolante', 'Location', 'northwest');     % ('Location', 'northwest') serve per mettere la legenda in alto a sx
title('Grafico sforzo/deformazione')
hold off;