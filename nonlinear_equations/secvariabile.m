function [x, iter, scarti] = secvariabile(f, x0, x1, tol, itmax)

%----------------------------------------------------------------
% parametri di input: 
%        f: funzione della quale si cerca una radice in [a,b]
%        x0 : approssimazione iniziale
%        x1 : approssimazione iniziale
%        toll: tolleranza  
%        itmax: numero massimo di iterazioni 
% parametri di output: 
%        x: vettore delle approssimazione della radice 
%        iter:  numero di iterazioni effettuate
%        scarti: vettore degli scarti successivi
%----------------------------------------------------------------

xoldold = x0;
xold = x1;
x = [x0];
x = [x; x1];
scarti = [];
dif = tol + 1;     % deve essere inizializzato ad un valore maggiore della tolleranza
iter = 0;

while (abs(dif) > tol) && (iter < itmax)
    % valuto f in xold e xoldold
   fx_old = feval(f, xold);
   fx_oldold = feval(f, xoldold);

   if fx_old == 0 
       return; 
   end

   if (xold - xoldold) ~= 0
       % calcolo h
       h = (fx_old - fx_oldold) / (xold - xoldold);
   else
       disp('ERRORE: xold - xoldold = 0.'); 
       return;
   end
   
   iter = iter + 1;
   dif = -fx_old / h;
   xnew = xold + dif;
   scarti = [scarti; dif];    % per aggiungere al vettore scarti il valore diff in ultima posizione (aggiunta in coda)
   
   x = [x; xnew];

   % aggiorno i valori delle x
   xoldold = xold;
   xold = xnew;
end
if (iter >= itmax)
   disp('raggiunto il numero massimo di iterazioni')
end
fprintf('\n');