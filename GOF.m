%% Descrizione
% questa funzione calcola la GOF
% 
% @Authors
% Vito Giacalone (481113)   /ing. inf.
% Alessio Daniele Ferrari (480163)  /ing. ind.
%



function [stima, thetaGOF] = GOF (phi, theta, yr)

stima = expit(phi*theta);
phiGOF = [ones(length(stima), 1), stima]; 
thetaGOF = lscov(phiGOF, yr);

end