% Robert Martinez
% SID: 861238333
% 4/8/17
% CS171 PS1

function [ avg_sqr_err ] = llserr( X, Y, w, b )

%%%%%% INPUTS %%%%%%%%%%%%%%%%%%%
% X is a data Matrix of features
% Y a vector of target outputs
% w a weight vector
% b an offset vector

%%%%%%% OUTPUT %%%%%%%%%%%%%%%%%%
% Returns a single scalar value average square error


[row, col] = size(X);
one_vector = ones(row,1);
% appending mX1 vector of ones to X that is the 
% used for the offset
X = [one_vector X];

% adding the offset to weight col_vector
w = [b; w];

% getting predicted value by multiplying
% every row in X by its respective weight in w
predicted_output = X *w;

% obtaining the squared error by taking the difference
% of the target value and predicted value squared.
% this will result in a mx1 matrix
squared_error = (Y-predicted_output).^2;

[row col] = size(squared_error);

%summing all squared errors
sum_sq_error = sum(squared_error);

% taking average of all squared errors
% by taking the sum and dividing it by
% the number of samples or rows
avg_sqr_err = (sum_sq_error/row);


end

