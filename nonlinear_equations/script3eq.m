% --------------------------------------%
% ESERCIZI FACCHIN ALBERTO SM32021282   %
% --------------------------------------%

% Di seguito ho commentato due delle tre equazioni di cui era richiesto di
% trovare un'approssimazione alpha dello zero. Nel caso in cui si voglia
% trovarla per un'equazione diversa da quella attualmente senza commenti
% basta toglierli dalla relativa sezione e commentare l'altra sezione.
% Ogni sezione è delimitata dalle linee tratteggiate.

% Prima equazione ---------------------------------------------------
f = @(x) exp(-x/4) - x;
df = @(x) -0.25*exp(-x/4) - 1;
a = 0; b = 2;
% -------------------------------------------------------------------

% Seconda equazione -------------------------------------------------
% f = @(x) x.^3 - 2;
% df = @(x) x.^2 .*3;
% a = 1; b = 2;
% -------------------------------------------------------------------

% Terza equazione ---------------------------------------------------
% f = @(x) x.*log(x) - 1;
% df = @(x) log(x) + 1;
% a = 1; b = 2;
% -------------------------------------------------------------------



% inizializza i parametri
toll = 1e-8;
tolintv = 1e-8;
itmax = 100;
x0 = 1;

% chiamata alla function bisezione
[c, iter, semilun, res] = bisezione(a, b, tolintv, toll, itmax, f);

% stampa a video dei risultati per bisezione
for k = 1:iter
fprintf('\n [k]:%3.0f [c]: %15.15f [AMP]: %2.2e [WRES]:%2.2e  ', k, c(k), semilun(k), res(k))
end
fprintf('\n');

% calcola e stampa del numero di iterazioni stimate per bisezione
ite_stim = (log(b-a) - log(toll)) / log(2) - 1;
fprintf('Il numero di iterazioni stimate per bisezione è: %d \n', ite_stim);

% chiamata alla function Newton
[x, iterN, scarti] = newton(f, df, x0, toll, itmax);

% stampa a video dei risultati per Newton
fprintf('\n [k]: %2.0f \t [xk]: %10.15f \t [dif]: ', 1, x(1));
for k = 2:iterN+1
fprintf('\n [k]: %2.0f \t [xk]: %10.15f \t [dif]: %10.2e', k, x(k), scarti(k-1));
end
fprintf('\n');

% crea grafico con il profilo di convergenza
figure(2)
semilogy(1:iter, abs(res), 'm-*', 1:iterN, abs(scarti), 'g-o');     % semilogy serve per avere l'asse y in scala logaritmica
legend('Bisezione', 'Newton');

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
print -dpdf grafico_scriptbisnew.pdf

