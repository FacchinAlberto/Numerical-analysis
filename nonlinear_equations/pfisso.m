function [xvec, iter, scarti, asint1] = pfisso (phi, x0, tol, itmax)

%----------------------------------------------------------------
% parametri di input: 
%        phi: funzione della quale si cerca una radice
%        x0 : approssimazione iniziale
%        toll: tolleranza  
%        itmax: numero massimo di iterazioni 
% parametri di output: 
%        x: vettore delle approssimazione della radice 
%        iter:  numero di iterazioni effettuate
%        scarti: vettore degli scarti successivi
%        asint1: stima della costante asintotica
%----------------------------------------------------------------

xold = x0;
xvec = [x0];
scarti = [];
dif = tol + 1;     % deve essere inizializzato ad un valore maggiore della tolleranza
iter = 0;
while (abs(dif) > tol) && (iter < itmax)
   phix = feval(phi, xold);   %feval serve per valutare la funzione f nel punto xold (in questo caso)
   if phix == 0 
       return; 
   end

   iter = iter + 1;
   xnew = phix;
   dif = phix - xold;
   scarti = [scarti; dif];    % per aggiungere al vettore scarti il valore diff in ultima posizione (aggiunta in coda)
   xvec = [xvec; xnew];
   xold = xnew;
end

% calcolo asint1
asint1 = abs(scarti(2:iter)./scarti(1:iter-1));

if (iter >= itmax)
   disp('raggiunto il numero massimo di iterazioni')
end
fprintf('\n');