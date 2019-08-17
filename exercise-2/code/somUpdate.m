function somUpdate(pattern,learningRate,neighborDist)

global IW N;

%find neighborhood for this pattern
a = somActivation(pattern,neighborDist); 
pattern_row = pattern.';
for i = 1:N,
    
    IW(i, :) = IW(i, :) +  learningRate * a(i) * (pattern_row - IW(i,:));
end
