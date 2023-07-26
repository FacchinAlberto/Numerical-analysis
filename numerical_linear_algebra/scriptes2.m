% --------------------------------------%
% ESERCIZI FACCHIN ALBERTO SM32021282   %
% --------------------------------------%

% Script per la risoluzione dell'esercizio 2 del file
% Esercizio_proposto.pdf, alla fine vi sono anche le risposte per
% l'esercizio 3

% ESERCIZIO 2

% (a)
n = 8;
A = hilb(n);    % A(i, j) = 1/(i + j - 1)
% cond(A)
eps = 1e-12;
A(2, 1) = 2*A(1, 1);
A(2, 2) = 2*A(1, 2) - eps;

% (b)
xvera = ones(n, 1);
b = A*xvera;

% (c)
[L, U] = lugauss(A);
y = L\b;
x = U\y;

% (d)
format long;
x

% (e)
r_rel = norm(b - A*x)/norm(b);
e_rel = norm(x - xvera)/norm(xvera);
fprintf('\n \t [RESIDUO RELATIVO]   %3.3e', r_rel);
fprintf('\n \t [ERRORE RELATIVO]    %3.3e', e_rel);
fprintf('\n ');

% (f)
[Lp, Up, Pp] = lu(A);   % Ax = b, PA = LU
yp = Lp\(Pp * b);  % Ly = Pb
xp = Up\yp; % Ux = y
xp
r_rel_p = norm(b - A*xp)/norm(b);
e_rel_p = norm(xp - xvera)/norm(xvera);
fprintf('\n \t [RESIDUO RELATIVO]   %3.3e', r_rel_p);
fprintf('\n \t [ERRORE RELATIVO]    %3.3e', e_rel_p);
fprintf('\n ');
