%Robert Martinez
% SID: 861238333
% cs171
% PS2

function [err,C] = knntest(TrainX, TrainY, TestX, TestY, k, lnorm)
%
% a stub
% your solution should report the total number of errors on the Test
% set using k-nearest neighbors with the supplied k and lnorm
% (lnorm=1 for Manhattan and 2 for Euclidean)
% It should also report C, the confusion matrix.  The i-j element of
% C is the fraction of the total examples who were labeled as class i
% and the true label was class j

%Construct distance matrix
[mA n] = size(TrainX);
[mB n] = size(TestX);
a = permute(TrainX, [1 3 2]);
a = repmat(a, [1 mB 1]);
b = permute(TestX, [3 1 2]);
b = repmat(b,[mA 1 1]);
diff = a - b;

%Manhattan
if lnorm == 1
    dist_mat = sum(abs(diff),3);
    
%Euclidean
elseif lnorm == 2
    square = diff .* diff;
    dist_mat = sum(square,3);
end

%sort distance matrix to find the kth nearest 
[sorted_matrix, index_mat] = sort(dist_mat,1);

correct = zeros(size(TestX,1),1);
confusion = zeros(size(unique(TrainY),1));

for i=1:size(TestX,1)
    test_pnt_class = TestY(i);
    k_nearest = TrainY(index_mat(1:k,i));
    % see which class is most reccuring to choose class
    [prediction ~] = mode(k_nearest);
    
    if prediction == test_pnt_class
        correct(i) = correct(i) + 1;
    end
    % construct confusion matrix using indices+1 of prediction and test
    % points
    prediction = prediction +1;
    test_pnt_class = test_pnt_class +1;
    confusion(prediction,test_pnt_class) = confusion(prediction,test_pnt_class) +1;;
    
    
end
% Confusion matrix is the 
C = confusion/mB;
err = 1 -(sum(correct)/size(correct,1));

