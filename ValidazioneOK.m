%% Descrizione: questo script si occupa della fase di Validazione dei modelli. Il metodo utilizzato è quello della cross validazione.
% in fine viene stampata una tabella per il confronto fra i vari modelli e
% i vari criteri utilizzati.
%
% @Authors
% Vito Giacalone (481113)   /ing. inf.
% Alessio Daniele Ferrari (480163)  /ing. ind.

%% Preparazione vettori utili
close all

wpV = Validazione(:,1);
wsV = Validazione(:,2);
wdV = (pi/180) * Validazione(:,3);

Parameters = [length(theta), length(theta2), length(theta3), length(thetat), length(thetat2), length(thetat3), length(rA)];


%% crossvalidazione

%matrici di sensitività dati validazione
phiV = [ones(length(wpV), 1), wsV];
phi2V = [ones(length(wpV), 1), wsV, wsV.^2];
phi3V = [ones(length(wpV), 1), wsV, wsV.^2, wsV.^3];
phitV = [ones(length(wpV), 1), wsV, cos(wdV), sin(wdV)];
phit2V = [ones(length(wpV), 1), wsV, cos(wdV), sin(wdV), cos(2*wdV), sin(2*wdV)];
phit3V = [ones(length(wpV), 1), wsV, cos(wdV), sin(wdV), cos(2*wdV), sin(2*wdV), cos(3*wdV), sin(3*wdV)];
phithV = wsV.^3;

[epsilonV, ssrV, rmseV] = ssrAndRMSE(wpV, expit(phiV*theta));
[epsilonV2, ssrV2, rmseV2] = ssrAndRMSE(wpV, expit(phi2V*theta2));
[epsilonV3, ssrV3, rmseV3] = ssrAndRMSE(wpV, expit(phi3V*theta3));
[epsilonVt, ssrVt, rmseVt] = ssrAndRMSE(wpV, expit(phitV*thetat));
[epsilonVt2, ssrVt2, rmseVt2] = ssrAndRMSE(wpV, expit(phit2V*thetat2));
[epsilonVt3, ssrVt3, rmseVt3] = ssrAndRMSE(wpV, expit(phit3V*thetat3));
[epsilonVth, ssrVth, rmseVth] = ssrAndRMSE(wpV, phithV*rA);




SSRV = [ssrV, ssrV2, ssrV3, ssrVt, ssrVt2, ssrVt3, ssrVth];
RMSE = [rmseV, rmseV2, rmseV3, rmseVt, rmseVt2, rmseVt3, rmseVth];

%% Tabella confronti

T = table(Parameters(:), RMSE(:), RMSEI(:), SSRV(:), FPE(:), AIC(:), MDL(:),'VariableNames',{'Parametri', 'RMSE validazione', 'RMSE identificazione', 'SSR in CrossValidazione', 'FPE','AIC', 'MDL'}, 'RowName',{'Lineare','Quadratico','Cubico','Trigonometrico', 'Trigonometrico con armoniche del secondo ordine', 'Trigonometrico con armoniche del terzo ordine', 'Teorico'});
disp(T)

