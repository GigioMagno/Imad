%% Descrizione
% questa funzione salva in memoria (e in particolare nella directory
% corrente di lavoro) l'immagine a colori in formato png della figura corrente.
% 
% @Authors
% Vito Giacalone (481113)   /ing. inf.
% Alessio Daniele Ferrari (480163)  /ing. ind.
%

function saveImg(String, format)
f = getframe(gcf);
[im,map] = rgb2ind(f.cdata,256,'nodither');
imwrite(im, map, String, format);
end
