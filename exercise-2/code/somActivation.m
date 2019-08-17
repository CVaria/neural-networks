function [a] = somActivation(pattern,neighborDist)

%distances of nodes NxN
%this matrix was created in somCreate.m
global distances;

%neighborDist = max distance of a neighbor 

%find position of winner node
out =somOutput(pattern);
winner_pos = find(out);

%if distance of winner_pos and i node is > of neighborDist 
%then a[i]=0 else a[i]=1
a = distances(winner_pos,:) <= neighborDist;
a = a .*0.5;
a(winner_pos)=1;




