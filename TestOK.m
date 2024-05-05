%% Descrizione: questo script si occupa della fase di test dei modelli. Viene fatto il Goodness of Fit.
% Il GOF descrive quanto bene si adattano le previsioni di un modello ai dati reali
%
% @Authors
% Vito Giacalone (481113)   /ing. inf.
% Alessio Daniele Ferrari (480163)  /ing. ind.

close all
%% caricamento dati
wpT = Test(:,1);
wsT = Test(:,2);
wdT = Test(:,3);
 

%% GOF modello lineare
%la GOF si va a fare sulle potenze quindi la phi viene calcolata sulle
%potenze e  non sulle velocita

phiT = [ones(length(wpT), 1), wsT]; %costruisco la matrice phiGOF con le velocita per andare a stimare la potenza di test
 %expit(phiGOF*theta) calcola le potenze stimate coi parametri di identificazione nel dominio logit e li riporta in quello normale

%per verificare la bonta del mio modello vado a confrontare le potenze
%stimate con quelle effettive, una volta trovata la matrice delle potenze
%stimate le velocita non servono piu, vado a tracciare una curva POT.EFF.
%in funz. di POT.EST.

[wpeT, thetaGOFlin] = GOF(phiT, theta, wpT);

figure(1);
scatter(wpeT, wpT, 'x');
grid on;
hold on;
plot([0, 1], [0,1], 'LineWidth', 2);
plot([0, 1], thetaGOFlin(1) + thetaGOFlin(2)*[0,1], 'LineWidth', 2);
axis([0, 1, 0, 1]);
title('Goodness of fit lineare');
xlabel('Potenza stimata');
ylabel('Potenza reale');
 
% utilizzare theta di identificazione in test per la gof. quindi
% phigof*theta

%lungo x la previsione, lungo y quella misurata. identificare un modello
%polinomiale. il modello polinomiale ha come variabile indipendente la y
%predetta
saveImg('GOFlin.JPEG', 'JPEG')
%% GOF modello quadratico

phiT2 = [ones(length(wpT), 1), wsT, wsT.^2];

% questa matrice avra sempre 2 parametri indipendentemente dal modello, anche se dovessi avere un modello a 50 parametri verra stimato coi due parametri di uni e di potenza stimata, quello di potenza stimata dipendera dai parametri

[wpeT2, thetaGOF2] = GOF(phiT2, theta2, wpT);

figure(2);
scatter(wpeT2, wpT, 'x');
grid on;
hold on;
plot([0, 1], [0,1], 'LineWidth', 2);
plot([0, 1], thetaGOF2(1) + thetaGOF2(2)*[0,1], 'LineWidth', 2);
axis([0, 1, 0, 1]);

title('Goodness of fit quadratico');
xlabel('Potenza stimata');
ylabel('Potenza reale');

saveImg('GOFquad.JPEG', 'JPEG')

%% GOF modello cubico

phiT3 = [ones(length(wpT), 1), wsT, wsT.^2, wsT.^3];
[wpeT3, thetaGOF3] = GOF(phiT3, theta3, wpT);
figure(3);
scatter(wpeT3, wpT, 'x');
grid on;
hold on;
plot([0, 1], [0,1], 'LineWidth', 2);
plot([0, 1], thetaGOF3(1) + thetaGOF3(2)*[0,1], 'LineWidth', 2);
axis([0, 1, 0, 1]);

title('Goodness of fit cubico');
xlabel('Potenza stimata');
ylabel('Potenza reale');

saveImg('GOFcub.JPEG', 'JPEG')
%% GOF modello trigonometrico

phiTt = [ones(length(wpT), 1), wsT, cos(wdT), sin(wdT)];
[wpeTt, thetaGOFt] = GOF(phiTt, thetat, wpT);
figure(4);
scatter(wpeTt, wpT, 'x');
grid on;
hold on;
plot([0, 1], [0,1], 'LineWidth', 2);
plot([0, 1], thetaGOFt(1) + thetaGOFt(2)*[0,1], 'LineWidth', 2);
axis([0, 1, 0, 1]);

title('Goodness of fit trigonometrico');
xlabel('Potenza stimata');
ylabel('Potenza reale');

saveImg('GOFt.JPEG', 'JPEG')
%% GOF modello trigonometrico con armoniche fino al secondo ordine

phiTt2 = [ones(length(wpT), 1), wsT, cos(wdT), sin(wdT), cos(2*wdT), sin(2*wdT)];
[wpeTt2, thetaGOFt2] = GOF(phiTt2, thetat2, wpT);
figure(5);
scatter(wpeTt2, wpT, 'x');
grid on;
hold on;
plot([0, 1], [0,1], 'LineWidth', 2);
plot([0, 1], thetaGOFt2(1) + thetaGOFt2(2)*[0,1], 'LineWidth', 2);
axis([0, 1, 0, 1]);

title('Goodness of fit trigonometrico con armoniche fino al 2 ordine');
xlabel('Potenza stimata');
ylabel('Potenza reale');

saveImg('GOFt2.JPEG', 'JPEG')
%% GOF modello trigonometrico con armoniche fino al terzo ordine

phiTt3 = [ones(length(wpT), 1), wsT, cos(wdT), sin(wdT), cos(2*wdT), sin(2*wdT), cos(3*wdT), sin(3*wdT)];
[wpeTt3, thetaGOFt3] = GOF(phiTt3, thetat3, wpT);
figure(6);
scatter(wpeTt3, wpT, 'x');
grid on;
hold on;
plot([0, 1], [0,1], 'LineWidth', 2);
plot([0, 1], thetaGOFt3(1) + thetaGOFt3(2)*[0,1], 'LineWidth', 2);
axis([0, 1, 0, 1]);

title('Goodness of fit trigonometrico con armoniche fino al terzo ordine');
xlabel('Potenza stimata');
ylabel('Potenza reale');

saveImg('GOFt3.JPEG', 'JPEG')
%% GOF modello teorico

phiTth = wsT.^3;

wpeTth = phiTth*rA;
phiGOFth = [ones(length(wpeTth), 1), wpeTth]; %thetaGOF rappresenta la matrice dei parametri che stimano la POT.EFF. in funz di POT.EST.
thetaGOFth = lscov(phiGOFth, wpT);
wpeTthGOF = phiGOFth*thetaGOFth; %calcolo della funzione di potenza

figure(7);
scatter(wpeTth, wpT, 'x');
grid on;
hold on;
plot([0, 1], [0,1], 'LineWidth', 2);
plot([0, 1], thetaGOFth(1) + thetaGOFth(2)*[0,1], 'LineWidth', 2);
axis([0, 1, 0, 1]);

title('Goodness of fit teorico');
xlabel('Potenza stimata');
ylabel('Potenza reale');

saveImg('GOFth.JPEG', 'JPEG')