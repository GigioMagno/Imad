%% Descrizione: questo script si occupa della fase di identificazione del modello ottimo. Verranno provati più modelli: 
% lineare, quadratico, cubico, e alcuni trigonometrici. La funzione "Fit"
% stima col metodo dei minimi quadrati i parametri dei modelli.
% Nella parte finale vengono proposti alcuni criteri di valutazione oggettiva dei
% modelli.
% Se si gradisce, la funzione saveImg permette il salvataggio degli scatterplot. 
% NOTA: Inizializzare l'ultimo parametro della funzione "CampionamentoCasuale" se si intende ripetere l'esperimento con gli stessi dati.
%
% 
% @Authors
% Vito Giacalone (481113)   /ing. inf.
% Alessio Daniele Ferrari (480163)  /ing. ind.



%% Caricamento dati in modo casuale
clc; clear; close all;

[Training, Validazione, Test] = CampionamentoCasuale('test.csv','train.csv', 0.7, 0.2, 19);

wp = Training(:,1);
ws = Training(:,2);
wd = (pi/180) * Training(:,3); 

%% rappresentazione dati puliti
figure(1)
grid on
scatter(ws, wp, 'x')
xlabel('ws')
ylabel('wp')
title('dati puliti: potenza/velocità')
saveImg('figura1.JPEG', 'JPEG')

figure(2)
grid on
scatter(wd, wp, 'x')
xlabel('wd')
ylabel('wp')
title('dati puliti: potenza/direzione')
saveImg('figura2.JPEG', 'JPEG')

%% logit
wpl = logit(wp); % faccio la logit dei dati, wpl = wp con logit
figure(3)
scatter(ws, wpl, 'x');
title('scatter dati trasformati')
xlabel('ws');
ylabel('logit wp');
saveImg('figura3.JPEG', 'JPEG');

%% modello lineare
phi = [ones(length(ws), 1), ws];
[theta, dev, wpe, epsilon, ssr, rmse] = Fit(phi, wpl);
figure(4)
scatter(ws, wp, 'x');
title('modello lineare')
xlabel('ws');
ylabel('wp');
hold on
scatter(ws, wpe, '.' ,'yellow')
saveImg('figura4.JPEG', 'JPEG');


%% modello quadratico
% y = t1 + t2*ws +t3*ws^2
% wp = t1 + t2*ws
phi2 = [ones(length(ws), 1), ws, ws.^2];
[theta2, dev2, wpe2, epsilon2, ssr2, rmse2] = Fit(phi2, wpl);

figure(5)
scatter(ws, wp, 'x');
title('modello quadratico')
xlabel('ws');
ylabel('wp');
hold on
scatter(ws, wpe2, '.', 'red')
saveImg('figura5.JPEG', 'JPEG');


%% modello cubico
% y = t1 + t2*ws +t3*ws^2 + t4*ws^3
% wp = t1 + t2*ws
phi3 = [ones(length(ws), 1), ws, ws.^2, ws.^3];
[theta3, dev3, wpe3, epsilon3, ssr3, rmse3] = Fit(phi3, wpl);

figure(6)
scatter(ws, wp, 'x');
title('modello cubico')
xlabel('ws');
ylabel('wp');
hold on

scatter(ws, wpe3, '.', 'black')
saveImg('figura6.JPEG', 'JPEG');


figure(55)

scatter(ws, wpl, 'x');
title('modello cubico logit')
hold on
scatter(ws, phi3*theta3, '.');
saveImg('55.JPEG', 'JPEG');
%% modello trigonometrico
% y = t1 + t2*ws +t3*cos(wd) + t4*sin(wd)

phit = [ones(length(ws), 1), ws , cos(wd), sin(wd)];
[thetat, devt, wpet, epsilont, ssrt, rmset] = Fit(phit, wpl);

figure(7)
scatter3(ws, wd, wp, 'x');
title('modello trigonometrico')
xlabel('ws');
ylabel('wd');
zlabel('wp');

ws_grid = linspace (0, 14,100)';
wd_grid = linspace(0, 6, 100)';
[ws_mat, wd_mat] = meshgrid(ws_grid, wd_grid);
ws_vec = ws_mat(:);
wd_vec = wd_mat(:);
phi_grid = [ones(length(ws_vec), 1), ws_vec, cos(wd_vec), sin(wd_vec)];
wp_vec_logit = phi_grid * thetat;
wp_vec = expit(wp_vec_logit);
wp_mat = reshape(wp_vec, size(wd_mat));
hold on
mesh(ws_mat, wd_mat, wp_mat);

% rotate();

%% modello trigonometrico con armoniche del 2 ordine

phit2 = [ones(length(ws), 1), ws , cos(wd), sin(wd), cos(2*wd), sin(2*wd)];
[thetat2, devt2, wpet2, epsilont2, ssrt2, rmset2] = Fit(phit2, wpl);

figure(8)
scatter3(ws, wd, wp, 'x');
title('modello trigonometrico con armoniche del 2 ordine (sin e cos)')
xlabel('ws');
ylabel('wd');
zlabel('wp');

ws_grid2 = linspace (0, 14,100)';
wd_grid2 = linspace(0, 6, 100)';
[ws_mat2, wd_mat2] = meshgrid(ws_grid2, wd_grid2);
ws_vec2 = ws_mat2(:);
wd_vec2 = wd_mat2(:);
phi_grid2 = [ones(length(ws_vec2), 1), ws_vec2, cos(wd_vec2), sin(wd_vec2), cos(2*wd_vec2), sin(2*wd_vec2)];
wp_vec_logit2 = phi_grid2 * thetat2;
wp_vec2 = expit(wp_vec_logit2);
wp_mat2 = reshape(wp_vec2, size(wd_mat2));
hold on
mesh(ws_mat2, wd_mat2, wp_mat2);
saveImg('figura8.JPEG', 'JPEG');

%% modello trigonometrico con armoniche fino al 3 ordine

phit3 = [ones(length(ws), 1), ws , cos(wd), sin(wd), cos(2*wd), sin(2*wd), cos(3*wd), sin(3*wd)];
[thetat3, devt3, wpet3, epsilont3, ssrt3, rmset3] = Fit(phit3, wpl);

figure(9)
scatter3(ws, wd, wp, 'x');
title('modello trigonometrico con armoniche fino al 3 ordine')
xlabel('ws');
ylabel('wd');
zlabel('wp');

ws_grid3 = linspace (0, 14,100)';
wd_grid3 = linspace(0, 6, 100)';
[ws_mat3, wd_mat3] = meshgrid(ws_grid3, wd_grid3);
ws_vec3 = ws_mat3(:);
wd_vec3 = wd_mat3(:);
phi_grid3 = [ones(length(ws_vec3), 1), ws_vec3, cos(wd_vec3), sin(wd_vec3), cos(2*wd_vec3), sin(2*wd_vec3), cos(3*wd_vec3), sin(3*wd_vec3)];
wp_vec_logit3 = phi_grid3 * thetat3;
wp_vec3 = expit(wp_vec_logit3);
wp_mat3 = reshape(wp_vec3, size(wd_mat3));
hold on
mesh(ws_mat3, wd_mat3, wp_mat3);
saveImg('figura9.JPEG', 'JPEG');

%% Modello teorico
phith = ws.^3;
[rA, devrA] = lscov(phith,wp);
wpeth = phith*rA;
[epsilonth, ssrth, rmseth] = ssrAndRMSE(wp, wpeth);
figure(10)
scatter(ws, wp, 'x');
xlabel('ws');
ylabel('wp');
hold on
scatter(ws, wpeth, '.', 'yellow')
ylim([0, 1])
title('modello teorico con identificazione lineare')
saveImg('figura10.JPEG', 'JPEG');

%% rappresentazione dei modelli con logit

figure(3)
hold on
title('Confronto tra modelli')
scatter(ws, logit(wpe), '.', 'yellow');
scatter(ws, logit(wpe2), '.', 'red');
scatter(ws, logit(wpe3), '.', 'green');
saveImg('confronto.JPEG', 'JPEG');

%% applicazione criteri oggettivi
[FPE1, AIC1, MDL1] = objectiveCriteria(length(wp), length(theta),ssr);
[FPE2, AIC2, MDL2] = objectiveCriteria(length(wp), length(theta2),ssr2);
[FPE3, AIC3, MDL3] = objectiveCriteria(length(wp), length(theta3),ssr3);
[FPEt, AICt, MDLt] = objectiveCriteria(length(wp), length(thetat),ssrt);
[FPEt2, AICt2, MDLt2] = objectiveCriteria(length(wp), length(thetat2),ssrt2);
[FPEt3, AICt3, MDLt3] = objectiveCriteria(length(wp), length(thetat3),ssrt3);
[FPEth, AICth, MDLth] = objectiveCriteria(length(wp), length(rA),ssrth);

FPE = [FPE1, FPE2, FPE3, FPEt, FPEt2, FPEt3, FPEth];
AIC = [AIC1, AIC2, AIC3, AICt, AICt2, AICt3, AICth];
MDL = [MDL1, MDL2, MDL3, MDLt, MDLt2, MDLt3, MDLth];

RMSEI = [rmse, rmse2, rmse3, rmset, rmset2, rmset3, rmseth];

%% commento finale fase di identificazione
% come si può facilmente notare, RMSE in tutti i casi non varia di molto.
% Personalmente ritengo che il modello lineare sia quello più efficiente in
% fase di identificazione poichè negli altri modelli, dato l'aumento
% considerevole del numero dei parametri non ottengo miglioramenti
% apprezzabili.
% (esempio, rmse non cambia ordine di grandezza).

