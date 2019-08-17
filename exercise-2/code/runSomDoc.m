function runSomDoc(Patterns,titles, terms, grid_architecture, setOrderLR, setOrderSteps, setTuneLR, grid_type, dist_type)


global  IW  orderLR tuneLR distances N;
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

 new_P = full(tfidf1(Patterns));
 %new_Patterns =>dimensions 8296 x 500
 new_Patterns = new_P.';


for i = 1: size(new_Patterns,1)
       minMax(i,1) = min(new_Patterns(i,:));
       minMax(i,2) = max(new_Patterns(i,:));
end

gridSize = grid_architecture;
somCreate(minMax,gridSize, grid_type, dist_type);

orderLR = setOrderLR;
tuneLR = setTuneLR;

somTrainParameters(setOrderLR,setOrderSteps,setTuneLR);
%plot2DSomData(IW, distances,Patterns);
somTrain(new_Patterns);
IW

save('doc4.mat', 'IW', 'distances','gridSize')
DocProcess(Patterns,titles, terms, IW, distances, N, gridSize)

