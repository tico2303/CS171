% Robert Martinez
% SID: 861238333
% 4/8/17
% CS171 PS1

function [ w, b ] = ridgells( X, Y, lambda )
%%%%%%%% INPUTS %%%%%%%%%%%%%%
% Feature Matrix X (m-Samples X n-Features)
% Target Vector Y (m X 1)
% scalar lambda

%%%%%%%% OUPUTS %%%%%%%%%%%%%%
% weight vector w (n X 1)
% scalar offset b (w_0)

[row, col] = size(X);
one_vect= ones(row,1);

%adding row of ones to X(0)=1 so w(0)*1 = b
X = [one_vect X];

%creating Identity matrix that lambda is mult. by
I = eye([col+1,col+1]);

% Setting offset Regularization column to zero
% so that the offset is uneffected by lambda
I(1,1) = 0;
I = lambda *I;

% w = inv(X' * X)* X' * Y
pseudo_inv = inv((X' *X) + I) *X';

%size(pseudo_inv)
w = pseudo_inv *Y;
% w now has the b at its first index
% settting b to w(0)
b = w(1,:);

% removing b from w
w = w(2:end,:);



end

