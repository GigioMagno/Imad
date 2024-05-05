%% Descrizione
% questa funzione restituisce i valori di FPE, AIC, MDL calcolati noti
% numero di dati (N), numero di parametri (q) e ssr.
% 
% @Authors
% Vito Giacalone (481113)   /ing. inf.
% Alessio Daniele Ferrari (480163)  /ing. ind.
%

function [FPE, AIC, MDL] = objectiveCriteria(N, q, ssr)
FPE = (N+q)*ssr/(N-q);
AIC = (2*q/N) + log(ssr);
MDL = log(N)*q/N + log(ssr);
end