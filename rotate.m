%% Descrizione
% questa funzione ha il compito di effettuare la rotazione del frame
% corrente
% 
% @Authors
% Vito Giacalone (481113)   /ing. inf.
% Alessio Daniele Ferrari (480163)  /ing. ind.
%

function rotate()
az = 0;
el = 0;
view([az,el])
degStep = 1;
deltaT = 0.01;
fCount = 50;
f = getframe(gcf);
[im,map] = rgb2ind(f.cdata,256,'nodither');
im(1,1,1,fCount) = 0;
k = 1;

for i = 0:degStep:360
  az = i;
  view([az,el])
  f = getframe(gcf);
  im(:,:,1,k) = rgb2ind(f.cdata,map,'nodither');
  k = k + 1;
end

imwrite(im, map, 'Animation.gif', 'DelayTime', deltaT, 'LoopCount', inf)
end