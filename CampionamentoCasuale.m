%% Descrizione
% questa funzione restituisce 3 subset di dati, partendo dall'unione di 2
% dataset dati in input con il loro path.
% prima di effettuare la divisione dei dati, l'intero dataset viene
% mescolato casualmente.
% vengono specificati come altri parametri 3 valori.
% 2 floating point che rappresentano la divisione in
% percentuale dei dati. il primo valore rappresenta la percentuale di dati
% di train, il secondo quella di validazione. i dati di test vengono
% restituiti senza bisogno di specificare la percentuale.
% l'ultimo parametro rappresenta il seme della funzione rimescolamento. Il
% seme viene settato in modo da rendere ripetibile l'esperimento.
% vengono inoltre memorizzati i dataset.
% 
% @Authors
% Vito Giacalone (481113)   /ing. inf.
% Alessio Daniele Ferrari (480163)  /ing. ind.
%

function [Training, Validazione, Test] = CampionamentoCasuale(path1, path2, trainRatio, valRatio, seed)

train = load(path1);
test = load(path2);
t = [train; test];

wp = t(:,1);
ws = t(:,2);
wd = t(:,3);

%% pulitura da 0 e 1 (gli 0 e gli 1 li tolgo perchè al momento della trasformazione dei dati di potenza nel dominio della logit posso avere problemi di definizione della funzione logit stessa.)
ws = ws(wp ~= 0 & wp ~= 1);
wd = wd(wp ~= 0 & wp ~= 1);
wp = wp(wp ~= 0 & wp ~= 1);


%% trasformazione potenza nel dominio logit
wpl = logit(wp);


%% ulteriore pulitura. rimuovo le "righe" nel grafico
ws = ws(wpl > -3.5 & wpl < 4);
wd = wd(wpl > -3.5 & wpl < 4);
wp = wp(wpl > -3.5 & wpl < 4);

t = [wp, ws, wd];

size = height(t);

%% shuffling
rng(seed);
idx = randperm(size);
Training = t(idx(1:round(trainRatio*size)),:) ; 
Validazione = t(idx((round(trainRatio*size)+1:round((trainRatio+valRatio)*size))),:) ;
Test = t(idx((round((trainRatio+valRatio)*size)+1:end)),:) ;

end