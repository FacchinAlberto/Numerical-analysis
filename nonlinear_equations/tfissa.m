function [x, iter, scarti] = tfissa(f, df, x0, tol, itmax)

%----------------------------------------------------------------
% parametri di input: 
%        f: funzione della quale si cerca una radice in [a,b]
%        d: derivata prima di f
%        x0 : approssimazione iniziale
%        toll: tolleranza  
%        itmax: numero massimo di iterazioni 
% parametri di output: 
%        x: vettore delle approssimazione della radice 
%        iter:  numero di iterazioni effettuate
%        scarti: vettore degli scarti successivi
%----------------------------------------------------------------

xold = x0;
x = [x0];
scarti = [];
dif = tol + 1;     % deve essere inizializzato ad un valore maggiore della tolleranza
iter = 0;
while (abs(dif) > tol) && (iter < itmax)
   fx = feval(f, xold);   %feval serve per valutare la funzione f nel punto xold (in questo caso)
   if fx == 0 
       return; 
   end
   dfx_0 = feval(df, x0);
   if dfx_0 == 0 
      disp('ERRORE: derivata nulla.'); return; % posso usare anche error('ERRORE: derivata nulla.');
   end
   iter = iter + 1;
   dif = -fx / dfx_0;
   xnew = xold + dif;
   scarti = [scarti; dif];    % per aggiungere al vettore scarti il valore diff in ultima posizione (aggiunta in coda)
   x=[x; xnew];
   xold = xnew;
end
if (iter >= itmax)
   disp('raggiunto il numero massimo di iterazioni')
end
fprintf('\n');