function runSomGroup(Patterns, grid_architecture, setOrderLR, setOrderSteps, setTuneLR, grid_type, dist_type)

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

gridSize = grid_architecture;
somCreate(minMax,gridSize, grid_type, dist_type);

orderLR = setOrderLR;
tuneLR = setTuneLR;

somTrainParameters(setOrderLR,setOrderSteps,setTuneLR);
%plot2DSomData(IW, distances,Patterns);
somTrain(Patterns);
IW

%Find how many patterns belong to each team
team0=0;
team1=0;
for i = 1 : size(Patterns,2)
    if Patterns(3,i)== 1
        team1 = team1 + 1;
    else
        team0 = team0 + 1;
    end
end

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
name3 = strcat (name, '_Teams.txt')

fprintf('Patterns in each team\n')
team1
team0


%Find how many neurons belong to each team
neurons0 = 0;
neurons1 = 0;
borders = 0;
for i = 1 : size(IW,1)
    if abs(IW(i,3) - 1) == 1
        neurons0 = neurons0 + 1;
    elseif  single(IW(i,3))==1.0000
        neurons1 = neurons1 + 1;
    else
        borders = borders + 1;
    end
end

fprintf('\n Neurons in each team\n')
neurons1
neurons0
borders

 fid = fopen(name3, 'wt');
 fprintf(fid, 'team1 %d\n', team1);
 fprintf(fid, 'team0 %d\n', team0);
 fprintf(fid, 'neurons1 %d\n', neurons1);
 fprintf(fid, 'neurons0 %d\n', neurons0);
 fprintf(fid, 'borders %d\n', borders);
  fclose(fid);

fig=figure; 
plot2DSomData(IW, distances,Patterns);
saveas(fig, name1);

fig=figure;
somShow(IW,gridSize);
saveas(fig, name2);

%save('test.mat')