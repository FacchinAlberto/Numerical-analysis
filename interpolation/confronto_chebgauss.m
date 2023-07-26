n=15;
a=-1;
b=1;
clf;
xgc = chebgauss(a,b,n); % calcolo dei nodi di Gauss-Chebyshev
xgcl = chebgausslob(a,b,n); % calcolo dei nodi di Gauss-Chebyshev-Lobatto
plot(xgc,zeros(length(xgc),1),'r.');
hold on;
plot(xgcl,zeros(length(xgcl),1),'b*');
title('Confronto tra nodi di CG (rosso) e di GCL (blue)');
legend('Nodi GC',' Nodi GCL')
hold off
