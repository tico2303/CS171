%Robert Martinez
%SID: 861238333
%CS171
%PS3

function [ f a1 z1 w_1 w_2 ] = forward_prop(X,w_1, w_2, nhid)

%Construct a_1 and z_1
[m n] = size(X);
a_1 =  X * w_1;
z_1 = sigmoid(a_1);
[zm zn] = size(z_1);
z_1 = [ones(m,1) z_1];

%construct a_2 and z_2
a_2 = z_1 * w_2;
z_2 = sigmoid(a_2);
f = z_2;
a1 = a_1;
z1 = z_1;

end

