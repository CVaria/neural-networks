function runSomTSP(Patterns, grid_architecture, setOrderLR, setOrderSteps, setTuneLR, grid_type, dist_type)

global  IW  orderLR tuneLR distances;

for i = 1: size(Patterns,1)
       minMax(i,1) = min(Patterns(i,:));
       minMax(i,2) = max(Patterns(i,:));
end

gridSize = grid_architecture;
somCreateTSP(minMax,gridSize, grid_type, dist_type);

orderLR = setOrderLR;
tuneLR = setTuneLR;

somTrainParameters(setOrderLR,setOrderSteps,setTuneLR);
%plot2DSomData(IW, distances,Patterns);
somTrain(Patterns);

name = 'grid-';
name = strcat(name, int2str(gridSize(1,1)),'_');
name = strcat(name, int2str(gridSize(1,2)), '-');

%this is just to save images with suitable names
if dist_type == 1
    name=strcat(name,'linkdist');
else
    name= strcat(name, 'ringdist');
end

if grid_type == 4
    name=strcat(name,'-hextop');
elseif grid_type == 3
    name=strcat(name,'-randtop');
elseif grid_type == 2
    name=strcat(name,'-hexagonalTopology');
else 
    name=strcat(name,'-gridtop');
end

name1 = strcat(name,'.png')
name2 = strcat(name, '_2.png')
name3 = strcat(name, '_Results.txt')
name4 = strcat(name, '_Dists.txt')
fig=figure; 
plot2DSomData(IW, distances,Patterns);
saveas(fig, name1);

dlmwrite(name3 ,IW , ' ')
dlmwrite(name4, distances, ' ')

%fig=figure;
%somShow(IW,gridSize);
%saveas(fig, name2);