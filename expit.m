%% Descrizione
% questa funzione calcola l'inversa della funzione logit.
% 
% @Authors
% Vito Giacalone (481113)   /ing. inf.
% Alessio Daniele Ferrari (480163)  /ing. ind.
%

function res = expit(x)
 res = (exp(x)./(1+exp(x)));
end

