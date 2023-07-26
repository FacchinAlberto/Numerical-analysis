% --------------------------------------%
% ESERCIZI FACCHIN ALBERTO SM32021282   %
% --------------------------------------%

% inizializza i parametri
toll = 1e-7;
itmax = 100;
x0 = 1;
d = 0.1;   % diametro del tubo
NR = 100;  % numero di Reynolds
e_s = 1e-4;   % scabrezza del tubo (utilizzo e_s per non far confusione con e numero di Nepero)

% Equazione
phi = @(x) (-2 * log10(e_s / (3.51 * d) + 2.52 / (NR * sqrt(x)))).^-2;
dphi = @(x) ((-2 * log10(e_s / (3.51 * d) + 2.52 / (NR * sqrt(x)))).^-3) * (2.52 / (NR * sqrt(x.^3))) / (e_s / (3.51 * d) + 2.52 / (NR * sqrt(x)));
f = @(x) x + (2 * log10(e_s / (3.51 * d) + 2.52 / (NR * sqrt(x)))).^-2;    % mi serve definire f per le stampe dei grafici


warning('off','all');   % disattivo momentaneamente i warnings


% ----------------Punto-fisso-----------------%

% chiamata alla function punto fisso
[xvec, iter, scarti, asint1] = pfisso(phi, x0, toll, itmax);

% stampa a video dei risultati per punto fisso
fprintf('\nPunto fisso');
fprintf('\n [k]: %2.0f \t [xk]: %10.15f \t [dif]: ', 1, xvec(1));
for k = 2 : iter + 1
fprintf('\n [k]: %2.0f \t [xk]: %10.15f \t [dif]: %10.2e', k, xvec(k), scarti(k-1));
end
fprintf('\n');

% --------------------Costante-asintotica----------------- %
fprintf('\nStima della costante asintotica');
% asint2 = abs(feval(dphi, xvec));
c1 = asint1(size(asint1, 1));       % mi prendo solo l'ultimo valore
% c2 = asint2(size(asint2, 2));       % mi prendo solo l'ultimo valore
fprintf('\n [asint1]: %10.15f = %10.2e', c1, c1);
% fprintf('\n [asint2]: %10.15f = %10.2e', c2, c2);
fprintf('\n');


% ---------------Convergenza------------------%

% crea grafico con il profilo di convergenza
figure(2)
semilogy(1:iter, abs(scarti), 'm-*');     % semilogy serve per avere l'asse y in scala logaritmica
legend('Punto fisso');

% Manipolazione stringa per stampa
str_f = func2str(phi);
% str_f = erase(str_f, '.');  % per togliere i punti
str_f(1:4) = [];    % per togliere la parte '@(x)'
title(strcat('Profilo di convergenza per phi(x) = ', str_f));

% disegno il grafico di phi(x) e g(x) = x per vedere dove si intersecano
figure(3)
g = @(x) x;
fplot(phi, [a b]);
hold on;
fplot(g, [a b], ' m-');
plot([a b], [0 0], 'k-');
hold off;
title(strcat(str_f, ' VERSUS x')); 
legend(str_f, 'x', 'asse x');

% Disegna la funzione f(x) e l'asse x nella stessa figura
figure(1)
h = fplot(f, [a b]);
set(h, 'Color', 'b', 'Linestyle', '-', 'LineWidth', 2);
hold on; 
plot([a b], [0 0], 'k-'); 
hold off;
str_f = func2str(f);
% str_f = erase(str_f, '.');  % per togliere i punti
str_f(1:4) = [];    % per togliere la parte '@(x)'
title(strcat('Grafico della funzione f(x) = ', str_f));
legend(str_f, 'asse x');

xlabel('N. iterazioni');
ylabel('scarto / residuo pesato');
print -dpdf script_colebrook_white.pdf
warning('on','all');    % riattivo i warnings