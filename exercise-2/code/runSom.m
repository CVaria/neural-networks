function runSom(Patterns, grid_architecture, setOrderLR, setOrderSteps, setTuneLR, grid_type, dist_type)

global  IW  orderLR tuneLR distances;
%grid_architecture is used to determine number of nodes in grid [rows,
%columns]
%grid_type is used to determine grid topology
%grid_type = default : usage of gridtop
%grid_type = 2 : usage of hexagonalTopology
%grid_type = 3 : usage of randtop
%grid_type = 4 : usage of hextop

%dist_type is used to determine distance's calculation algorithm
%dist_type = default : dist - Euclidean distance
%dist_type = 2 : boxdist - box distance using a gridtop
%dist_type = 3 : linkdist - number of steps we need to reach a node
%dist_type = 4 : mandist - manhattan distance

for i = 1: size(Patterns,1)
       minMax(i,1) = min(Patterns(i,:));
       minMax(i,2) = max(Patterns(i,:));
end

gridSize = grid_architecture
somCreate(minMax,gridSize, grid_type, dist_type);

orderLR = setOrderLR
tuneLR = setTuneLR

somTrainParameters(setOrderLR,setOrderSteps,setTuneLR);
%plot2DSomData(IW, distances,Patterns);
somTrain(Patterns);
IW;

name = 'grid-';
name = strcat(name, int2str(gridSize(1,1)),'_');
name = strcat(name, int2str(gridSize(1,2)), '-');

%this is just to save images with suitable names
if dist_type == 4
    name=strcat(name,'mandist');
elseif dist_type == 3
    name=strcat(name, 'linkdist');
elseif dist_type == 2
    name= strcat(name,'boxdist');
else
    name= strcat(name, 'dist');
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

name1 = strcat(name,'_1.png')
name2 = strcat(name, '_2.png')

fig=figure; 
plot2DSomData(IW, distances,Patterns);
saveas(fig, name1);

fig=figure;
somShow(IW,gridSize);
saveas(fig, name2);