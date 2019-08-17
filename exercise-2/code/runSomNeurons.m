function runSomNeurons(Patterns, setOrderLR, setOrderSteps, setTuneLR, grid_type, dist_type)

list_of_arch = [3 1; 20 10; 12 9; 4 8; 2 5; 10 10; 30 10; 5 5; 6 2; 45 2; 3 3; 1 6 ; 15 15; 3 8; 8 7; 40 9; 3 20; 8 8]

for i = 1:size(list_of_arch)
        runSom(Patterns, [list_of_arch(i,1) list_of_arch(i,2)], setOrderLR, setOrderSteps, setTuneLR, grid_type, dist_type)
end