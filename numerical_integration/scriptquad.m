% --------------------------------------%
% ESERCIZI FACCHIN ALBERTO SM32021282   %
% --------------------------------------%

% FUNZIONE INTEGRANDA
f = @(x) (x.^20).*(exp(x - 1));
% INTERVALLO D'INTEGRAZIONE
a = 0; b = 1; 
% Valore vero dell'integrale definito
Ivero = quad(f, a, b);

% INTESTAZIONE TABELLA RISULTATI
fprintf('\n %8s %15s %16s %15s %16s', 'N', 'Itrap', 'Etrap',...
 'Isimp', 'Esimp');

% CREAZIONE VETTORI DEGLI ERRORI
err_t = [];
err_s = [];

for nval = 2:2:512

   % NUMERO SUBINTERVALLI PER TRAPEZI COMPOSTA.
   N_trap = nval - 1;        
   [x_trap, w_trap, Itrap] = trapezi_composta(N_trap, a, b, f);

   % NUMERO SUBINTERVALLI PER CAV.SIMPSON COMPOSTA.
   N_simpson = (nval - 1)/2; 
   [x_simp,w_simp, Isimp] = simpson_composta(N_simpson, a, b, f);

   % CALCOLO DEGLI ERRORI ASSOLUTI
   Etrap = abs(Ivero - Itrap);
   Esimp = abs(Ivero - Isimp);

   % SALVATAGGIO RISULTATI ERRORI NEI RISPETTIVI VETTORI
   err_t = [err_t; Etrap];
   err_s = [err_s; Esimp];

   % STAMPA DEI VALORI APPROSSIMATI E DEGLI ERRORI ASSOLUTI
   fprintf(' \n %7d %20.14f %12.3E  %18.14f %13.3E', nval, Itrap, Etrap, Isimp, Esimp);
   fprintf(' \n');
end

% GRAFICO DEGLI ERRORI IN FUNZIONE DI N
figure(1)
loglog(2:2:512, err_t, 'm-*', 2:2:512, err_s, 'g-o');
legend('Trapezi', 'Simpson');
xlabel("N")
ylabel("Errore")
title("Grafico degli errori")

% CREAZIONE PDF DEL GRAFICO
print -dpdf graficoquad.pdf


% ESERCIZIO 3 -------------------------------------------------------------
% FUNZIONE INTEGRANDA
n = 20;
g = @(x) (x.^n).*(exp(x - 1));
% INTERVALLO D'INTEGRAZIONE
a = 0; b = 1; 
% Valore vero dell'integrale definito
I = [];
I(1) = exp(-1);
for n = 2:21
    I(n) = 1 - (n*I(n-1));
end

fprintf(' \n I20 = %20.14f', I(21));
Esucc = abs(Ivero - I(21));
fprintf('\n %15s %16s %15s %16s %15s %16s', 'Itrap', 'Etrap', 'Isimp', 'Esimp', 'I(20)', 'E[I(20)]');
fprintf(' \n %20.14f %13.3E %20.14f %13.3E %20.14f %13.3E', Itrap, Etrap, Isimp, Esimp, I(21), Esucc);

% Avendo usato una formula che, per calcolare I(n+1), utilizza I(n), se vi
% è un errore in I(n), questo viene propogato, per questo motivo,
% probabilmente, calcolando, per esempio, I(100), avremmo un errore ancora 
% maggiore, cioè al tendere di n ad infinito anche l'errore tenderà ad 
% infinito.