% Definizione della funzione e dell'intervallo

f=@(x) 5.*x - exp(-x); 
a=-2; 
b=2;

% Inizializzazione dei parametri di ingresso
tolres=1e-8;tolintv=1e-8;maxit=100;

% Chiamata alla function bisezione perche' venga eseguita
[c,iter,sl,wr]=bisezione(a,b,tolintv,tolres,maxit,f);

%Stampa dei risultati mediante un ciclo for
for k=1:iter
fprintf('\n [k]:%3.0f [c]: %15.15f [AMP]: %5.2e [WRES]:%5.2e  ',k,c(k),sl(k),wr(k))
end
fprintf('\n');

ite_stim = (log(b-a) - log(tolres)) / log(2);
fprintf('Il numero di iterazioni stimate è: %d', ite_stim);

%Grafico con il profilo di convergenza
%Usando il comando semilogy
semilogy(wr)
