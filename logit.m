%% Descrizione
% questa funzione restituisce calcola la logit del vettore in input
% 
% @Authors
% Vito Giacalone (481113)   /ing. inf.
% Alessio Daniele Ferrari (480163)  /ing. ind.
%


function res = logit(x)
res = log(x./(1-x));
end