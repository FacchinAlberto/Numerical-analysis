function xc = chebgausslob(a, b, n)
% calcola n nodi di Gauss-Chebyshev-Lobatto (scalati: traslati in [a, b])
% USO:  xc = chebgausslob(a, b, n)
% Ordinati in senso decrescente
for k = 1:1:n
    xc(k) = (a + b)/2 + ((b - a)/2)*cos(pi*(k - 1)/(n - 1));
end
