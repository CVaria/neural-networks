function [output]=somOutput(pattern)

global IW;
%IW = NxD matrix with nodes' weights
%pattern = Dx1 vector with characteristics of input p

x = negdist(IW, pattern);
output = compet(x);