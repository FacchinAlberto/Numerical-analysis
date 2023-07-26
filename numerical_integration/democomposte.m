% SCRIPT PER USARE LE FORMULE DI QUADRATURA COMPOSTE

% FUNZIONE INTEGRANDA
% caso a
f = @(x) x.^20;
% INTERVALLO D'INTEGRAZIONE
% caso a
a=-1; b=1; 

% Valore vero dell'integrale definito caso a
Ivero=2/21;

% INTESTAZIONE TABELLA RISULTATI
fprintf('\n %8s %15s %16s %15s %16s ','NODI', 'I_TRAP', 'ERR. REL' ,...
 'I_SIMPSON','ERR. REL'  );
% APERTURA FILE DI RISULTATI 
%fid=fopen('tabellaquad1.ris','w');
for nval=[11,51,101,301,501]

%nval=11; % Numero di valutazioni di funzione (nodi)

   % NUMERO SUBINTERVALLI PER TRAPEZI COMPOSTA.
   N_trap=nval-1;        
   [x_trap,w_trap, I_trap]=trapezi_composta(N_trap,a,b,f);

   % NUMERO SUBINTERVALLI PER CAV.SIMPSON COMPOSTA.
   N_simpson=(nval-1)/2; 
   [x_simp,w_simp, I_simp]=simpson_composta(N_simpson,a,b,f);


   % CALCOLO DEGLI ERRORI ASSOLUTI
   E_trap = abs(Ivero - I_trap);
   E_simp = abs(Ivero - I_simp);
%  STAMPA DEI VALORI APPROSSIMATI E DEGLI ERRORI RELATIVI! 
   fprintf(' \n %7d %20.14f %12.3E  %18.14f %13.3E',nval,I_trap,E_trap/Ivero,I_simp,E_simp/Ivero);
fprintf(' \n');
end

% per stampare su file, dopo averlo aperto
%   fprintf(fid,' \n %7d %20.14f %12.3E  %18.14f %13.3E',nval,I_trap,E_trap,I_simp,E_simp);
%fprintf(fid,' \n');
%fclose(fid);

