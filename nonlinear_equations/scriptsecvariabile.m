% --------------------------------------%
% ESERCIZI FACCHIN ALBERTO SM32021282   %
% --------------------------------------%

% Equazione
 f = @(x) exp(-x) + cos(x) -3;
 a = -pi; b = pi;

% inizializza i parametri
toll = 1e-10;
itmax = 100;
x0 = -1.5;
x1 = -1;


% ------------Secante-variabile---------------%

% chiamata alla function secante variabile
[x, iter, scarti] = secvariabile(f, x0, x1, toll, itmax);

% stampa a video dei risultati per secante variabile
fprintf('\n [k]: %2.0f \t [xk]: %10.15f \t [dif]: ', 1, x(1));
for k = 2 : iter + 1
fprintf('\n [k]: %2.0f \t [xk]: %10.15f \t [dif]: %10.2e', k, x(k), scarti(k-1));
end
fprintf('\n');

% ---------------Convergenza------------------%

% crea grafico con il profilo di convergenza
figure(2)
semilogy(1:iter, abs(scarti), 'm-*');     % semilogy serve per avere l'asse y in scala logaritmica
legend('Secante variabile');

% Manipolazione stringa per stampa
str_f = func2str(f);
str_f = erase(str_f, '.');  % per togliere i punti
str_f(1:4) = [];    % per togliere la parte '@(x)'
title(strcat('Profilo di convergenza per f(x) = ', str_f)); %strcat per concatenare stringhe

% facendo come segue andrebbe a capo
% title('Profilo di convergenza dei due metodi per f(x) = ', str_f);

% Disegna la funzione f(x) e l'asse x nella stessa figura
figure(1)
h = fplot(f, [a b]);
set(h, 'Color', 'b', 'Linestyle', '-', 'LineWidth', 2);
hold on; 
plot([a b], [0 0], 'k-'); 
hold off;
title(strcat('Grafico della funzione f(x) = ', str_f));
legend(str_f, 'asse x');

xlabel('N. iterazioni');
ylabel('scarto / residuo pesato');
print -dpdf grafico_scriptsecvariabile.pdf