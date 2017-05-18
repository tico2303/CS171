% Robert Martinez
% SID: 861238333
% CS171
% PS3

function [ z ] = sigmoid( a )
% sigmoid activation function

z = 1./(1 + (exp(-a)));
end

