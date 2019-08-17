function somCreateTSP(minMax,gridSize, grid_type, dist_type)

global neuronsPerRow neuronsPerColumn N IW distances dimensions positions;

neuronsPerRow = gridSize(1,1);
neuronsPerColumn = gridSize(1,2);
N = neuronsPerRow*neuronsPerColumn;

minFeatureValues = minMax(:,1)';
maxFeatureValues = minMax(:,2)';
dimensions = size(minMax,1);

%returns matrix full of zeros
IW = zeros(N,dimensions);

for i = 1:N,
    IW(i,:) = rand(1,dimensions).*(maxFeatureValues-minFeatureValues)+minFeatureValues;
end


if grid_type == 4
    fprintf('grid_type = hextop\n')
    positions = hextop(neuronsPerRow,neuronsPerColumn);
elseif grid_type == 3
    fprintf('grid_type = randtop\n')
    positions = randtop(neuronsPerRow,neuronsPerColumn);
elseif grid_type == 2
    fprintf('grid_type = hexagonalTopology\n')
    positions = hexagonalTopology(neuronsPerRow,neuronsPerColumn);
else 
    fprintf('grid_type = gridtop\n')
    positions = gridtop(neuronsPerRow,neuronsPerColumn);
end

if dist_type == 1
    fprintf('dist_type = linkdist\n')
    distances = linkdist(positions);
else
    fprintf('dist_type = ringdist\n')
    distances = ring_distances(N);
end