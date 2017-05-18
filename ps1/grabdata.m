function [ X,Y,Z,ZY ] = grabdata( train_filename, test_filename )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
x = importdata(train_filename);
z = importdata(test_filename);

%grab target values
y = x(:,end);
zy = z(:,end);

%create feature matrix
[x_row x_col] = size(x);
[z_row z_col] = size(z);

x = x(:,1:x_col-1);
z = z(:,1:z_col-1);

X = x;
Y = y;
Z = z;
ZY = zy;

end

