function [ loss ] = lossFunction( f,y )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

loss = -(y*log(f) + (1-y)*log(1-f))

end

