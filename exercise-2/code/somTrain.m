function somTrain(patterns)
%patterns => DxP
%usage of linspace: exp(linspace(logx, logy, epochs)) x = maxNeighborDist
%y = tuneND and epochs in each order level

global orderSteps maxNeighborDist tuneND orderLR tuneLR; 


%P = size of input = number of columns
P = size(patterns, 2);
LR = linspace(log(orderLR), log(tuneLR), orderSteps);
ND = linspace(log(maxNeighborDist), log(tuneND), orderSteps);
fprintf('Ordering\n')

%ordering ??
for i = 1:orderSteps
    for j = 1:P
            somUpdate(patterns(:,j), exp(LR(i)), exp(ND(i)));
    end
end

fprintf('Tuning\n')
%tuning ??
for i = 1: (2*orderSteps)
    for j = 1:P
            somUpdate(patterns(:, j), tuneLR, tuneND);
    end
end