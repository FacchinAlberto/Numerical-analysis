% --------------------------------------%
% ESERCIZI FACCHIN ALBERTO SM32021282   %
% --------------------------------------%

% Di seguito ho commentato una delle due equazioni di cui era richiesto di
% trovare un'approssimazione alpha dello zero. Nel caso in cui si voglia
% trovarla per l'equazione commentata basta togliere i commenti presenti
% nella relativa sezione ed aggiungerli all'altra sezione.
% Ogni sezione è delimitata dalle linee tratteggiate.

% --------------------------- x = cos(x) ----------------------------
 phi = @(x) cos(x);
 dphi = @(x) -sin(x);
 f = @(x) x - cos(x);        % per Newton
 df = @(x) 1 + sin(x);
 x0 = 1;
 toll = 1e-10;
% -------------------------------------------------------------------

% ------------------------ x = 1 + arctan(x) ------------------------
% phi = @(x) 1 + atan(x);
% dphi = @(x) 1/(1 + x.^2);
% f = @(x) x - 1 - atan(x);        % per Newton
% df = @(x) 1 - 1/(1 + x.^2);
% x0 = 1;
% toll = 1e-12;
% -------------------------------------------------------------------



a = -2; b = 3;
itmax = 100;

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
asint2 = abs(feval(dphi, xvec));
c1 = asint1(size(asint1, 1));       % mi prendo solo l'ultimo valore
c2 = asint2(size(asint2, 2));       % mi prendo solo l'ultimo valore
fprintf('\n [asint1]: %10.15f = %10.2e', c1, c1);
fprintf('\n [asint2]: %10.15f = %10.2e', c2, c2);
fprintf('\n');



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


%-------------scrive-dati-su-file-------------%
fid = fopen('rispfisso.txt', 'w');
fprintf(fid, '\nPunto fisso');
fprintf(fid, '\n [k]: %2.0f \t [xk]: %10.15f \t [dif]: ', 1, xvec(1));
for k = 2 : iter + 1
fprintf(fid, '\n [k]: %2.0f \t [xk]: %10.15f \t [dif]: %10.2e', k, xvec(k), scarti(k-1));
end
fprintf(fid, '\n');
fprintf(fid, '\nNewton');
fprintf(fid, '\n [k]: %2.0f \t [xk]: %10.15f \t [dif]: ', 1, x_N(1));
for k = 2 : iter_N + 1
fprintf(fid, '\n [k]: %2.0f \t [xk]: %10.15f \t [dif]: %10.2e', k, x_N(k), scarti_N(k-1));
end
fclose(fid);



% ---------------Convergenza------------------%

% crea grafico con il profilo di convergenza
figure(2)
semilogy(1:iter, abs(scarti), 'm-*', 1:iter_N, abs(scarti_N), 'g-o');     % semilogy serve per avere l'asse y in scala logaritmica
legend('Punto fisso', 'Newton');

% Manipolazione stringa per stampa
str_f = func2str(phi);
str_f = erase(str_f, '.');  % per togliere i punti
str_f(1:4) = [];    % per togliere la parte '@(x)'
title(strcat('Profilo di convergenza dei due metodi per x = ', str_f));    %strcat per concatenare stringhe

% facendo come segue andrebbe a capo
% title('Profilo di convergenza dei due metodi per x = ', str_f);

% disegno il grafico di phi(x) e g(x) = x per vedere dove si intersecano
figure(3)
g = @(x) x;
fplot(phi, [a b]);
hold on;
fplot(g, [a b], ' m-');
plot([a b], [0 0], 'k-');
hold off;
title(strcat(str_f, ' VERSUS x')); 
legend(str_f, 'x', 'asse x', 'Location', 'northwest');

% Disegna la funzione f(x) e l'asse x nella stessa figura
figure(1)
h = fplot(f, [a b]);
set(h, 'Color', 'b', 'Linestyle', '-', 'LineWidth', 2);
hold on;
plot([a b], [0 0], 'k-'); 
hold off;
str_f = func2str(f);
str_f = erase(str_f, '.');  % per togliere i punti
str_f(1:4) = [];    % per togliere la parte '@(x)'
title(strcat('Grafico della funzione f(x) = ', str_f));
legend(str_f, 'asse x', 'Location', 'northwest');

xlabel('N. iterazioni');
ylabel('scarto / residuo pesato');
print -dpdf confronto.pdf