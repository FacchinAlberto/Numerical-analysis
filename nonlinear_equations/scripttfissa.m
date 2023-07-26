% --------------------------------------%
% ESERCIZI FACCHIN ALBERTO SM32021282   %
% --------------------------------------%

% Equazione
 f = @(x) exp(-x) + cos(x) -3;
 df = @(x) -exp(-x) - sin(x);
 a = -pi; b = pi;

% inizializza i parametri
toll = 1e-9;
itmax = 100;
x0 = -1;



% ------------------Newton--------------------%

% chiamata alla function Newton
[x_N, iter_N, scarti_N] = newton(f, df, x0, toll, itmax);

% stampa a video dei risultati per Newton
fprintf('\nNewton');
fprintf('\n [k]: %2.0f \t [xk]: %10.15f \t [dif]: ', 1, x_N(1));
for k = 2 : iter_N + 1
fprintf('\n [k]: %2.0f \t [xk]: %10.15f \t [dif]: %10.2e', k, x_N(k), scarti_N(k-1));
end
fprintf('\n');

% --------------Tangente-fissa----------------%

% chiamata alla function tangente fissa
[x_TF, iter_TF, scarti_TF] = tfissa(f, df, x0, toll, itmax);

% stampa a video dei risultati per tangente fissa
fprintf('\nTangente fissa');
fprintf('\n [k]: %2.0f \t [xk]: %10.15f \t [dif]: ', 1, x_TF(1));
for k = 2 : iter_TF + 1
fprintf('\n [k]: %2.0f \t [xk]: %10.15f \t [dif]: %10.2e', k, x_TF(k), scarti_TF(k-1));
end
fprintf('\n');

% ---------------Convergenza------------------%

% crea grafico con il profilo di convergenza
figure(2)
semilogy(1:iter_N, abs(scarti_N), 'm-*', 1:iter_TF, abs(scarti_TF), 'g-o');     % semilogy serve per avere l'asse y in scala logaritmica
legend('Newton', 'Tangente fissa');

% Manipolazione stringa per stampa
str_f = func2str(f);
str_f = erase(str_f, '.');  % per togliere i punti
str_f(1:4) = [];    % per togliere la parte '@(x)'
title(strcat('Profilo di convergenza dei due metodi per f(x) = ', str_f));  %strcat per concatenare stringhe

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
print -dpdf grafico_scripttfissa.pdf