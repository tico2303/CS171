% Robert Martinez
% SID: 861238333
% CS171
% PS3

function [ g_prime ] = sigmoid_prime( a )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

g_prime = sigmoid(a) .* (1 - sigmoid(a));
%size(g_prime)

end

