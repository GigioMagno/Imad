%% Descrizione
% questa funzione restituisce il vettore dei residui, l'ssr e l'rmse dati
% in ingresso 2 vettori. Il primo vettore è quello dei dati reali. Il
% secondo vettore è quello dei dati stimati.
% 
% @Authors
% Vito Giacalone (481113)   /ing. inf.
% Alessio Daniele Ferrari (480163)  /ing. ind.
%

%% Funzione
function [epsilon, ssr, rmse] = ssrAndRMSE(real, estimated)

epsilon = real - estimated;
ssr = epsilon'*epsilon;
rmse = sqrt(ssr/length(estimated));
end