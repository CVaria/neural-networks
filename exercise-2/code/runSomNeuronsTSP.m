function runSomNeuronsTSP(Patterns, setOrderLR, setOrderSteps, setTuneLR, grid_type, dist_type)

list_of_arch = [200 1; 160 1; 120 1; 100 1; 90 1; 80 1; 70 1; 1 90; 1 110; 1 300; 1 145]

for i = 1:size(list_of_arch)
        runSomTSP(Patterns, [list_of_arch(i,1) list_of_arch(i,2)], setOrderLR, setOrderSteps, setTuneLR, grid_type, dist_type)
end