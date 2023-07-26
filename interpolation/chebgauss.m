function xc = chebgauss(a,b,n)
% calcola n nodi di Gauss-Chebyshev (scalati: traslati in [a,b]) 
% USO:  xc = chebgauss(a,b,n)
% il vettore xc contiene i nodi ordinati in senso crescente
for k = 1:n
    xc(k) = (a + b)/2 - ((b - a)/2)*cos((2*k - 1)/(2*n)*pi);
end
