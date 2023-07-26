% --------------------------------------%
% ESERCIZI FACCHIN ALBERTO SM32021282   %
% --------------------------------------%

% Equazione
 f = @(x) ((x - 1).^2) .* log(x);
 df = @(x) 2.*(x - 1).*log(x) + ((x - 1).^2)./x;
 a = 1; b = 3;

% inizializza i parametri
toll = 1e-9;
r = 3;      % pongo r = 3 per ottenere convergenza quadratica (molteplicità dello zero è 3)
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

% -------------Newton-Modificato--------------%

% chiamata alla function Newton modificato
[x_NM, iter_NM, scarti_NM] = newtonmod(f, df, x0, toll, itmax, r);

% stampa a video dei risultati per Newton modificato
fprintf('\nNewton modificato');
fprintf('\n [k]: %2.0f \t [xk]: %10.15f \t [dif]: ', 1, x_NM(1));
for k = 2 : iter_NM + 1
fprintf('\n [k]: %2.0f \t [xk]: %10.15f \t [dif]: %10.2e', k, x_NM(k), scarti_NM(k-1));
end
fprintf('\n');

% ---------------Convergenza------------------%

% crea grafico con il profilo di convergenza
figure(2)
semilogy(1:iter_N, abs(scarti_N), 'm-*', 1:iter_NM, abs(scarti_NM), 'g-o');     % semilogy serve per avere l'asse y in scala logaritmica
legend('Newton', 'Newton modificato');

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
print -dpdf grafico_scriptmod.pdf

