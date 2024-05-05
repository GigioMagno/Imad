%% Descrizione
% questa funzione restituisce i parametri stimati del modello trigonometrico, la
% deviazione dei parametri, la stima, il vettore dei residui, la somma dei
% quadrati dei residui e l'rmse. dati in ingresso il regressore utilizzato
% e le "y".
% 
% @Authors
% Vito Giacalone (481113)   /ing. inf.
% Alessio Daniele Ferrari (480163)  /ing. ind.
%

function [theta, dev, y_hat, epsilon, ssr, rmse] = Fit(phi, yt)

[theta, dev] = lscov(phi, yt);
y_hat = expit(phi*theta);
[epsilon, ssr, rmse] = ssrAndRMSE(expit(yt), y_hat);
end