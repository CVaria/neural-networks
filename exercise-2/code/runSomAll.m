function runSomAll(Patterns, grid_architecture, setOrderLR, setOrderSteps, setTuneLR)

for i = 1:4
    for j = 1:4
        runSom(Patterns, grid_architecture, setOrderLR, setOrderSteps, setTuneLR, i, j)
    end
end