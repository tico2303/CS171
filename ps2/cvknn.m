%Robert Martinez
% SID: 861238333
% cs171
% PS2

function [k,lnorm] = cvknn(Xtrain,Ytrain,Xvalid,Yvalid,maxk)
% 
% a starting shell
% your solution should find the best k (from 1 to maxk, skipping even values)
% and lnorm (1 = Manhattan distance, 2 = Euclidean distance) combination
% for k-nearest neighbor using the supplied training and validation sets
%
% In doing so, it should generate a plot (do *not* call "figure" -- the
% calling function will set up for the right figure window to be active).
% The plot should be as described and illustrated in the problem set. 

k_values = [1:2:maxk];

% n or the number of feature should be the same
[mA n] = size(Xtrain);
[mB n] = size(Xvalid);

%%%%%%%%%%%% Euclidean and Manhattan %%%%%%%%%%%%%%%%%%%%%%%%%
% rotate Xtrain about the y-axis(swap 2 and 3) resulting in a 
% (mAx1xn)
a = permute(Xtrain, [1 3 2]);
% copy/extend matrix mB times along the x-axis
a = repmat(a, [1 mB 1]);
% dim(a) = (mA x mB x n)

% rotate Xvalid about the y-axis then about the z
% (1xmBxn)
b = permute(Xvalid, [3 1 2]);
% copy/extend matrix mA times along the y-axis 
b = repmat(b,[mA 1 1]);

diff = a - b;
square = diff .* diff;
% sum them about the z-axis
euclid_dist = sum(square,3);
manh_dist = sum(abs(diff),3);

% sort by column every 
% every ith row and jth column in the
% index matrix is distance between the ith Xtrain sample
% and the jth Xvalid sample
% indm is an index matrix after sorting
[sorted_euclid, indm_e] = sort(euclid_dist,1);
[sorted_manh, indm_m] = sort(manh_dist,1);


[km kn] = size(k_values);
%vector that counts correctly predicted values per k value
euclid_kays = zeros(kn,1);
manh_kays = zeros(kn,1);
ind = 1;

% Iterate over all k-values trying them on both distance metrics 
% and find the best distance matrix and k-value
for k=k_values
    %for every validation example 
    for i=1:mB
        % grab the class of the ith Xvalid instance
        test_point_class = Yvalid(i);
        % we now grab k rows from the index matrix
        % and use those indexes to find the kth Ytrain classes
        y_train_euclid = Ytrain(indm_e(1:k,i));
        y_train_manh = Ytrain(indm_m(1:k,i));
        
        % count most frequent class to get prediction
        [euclid_prediction, ~] = mode(y_train_euclid);
        [manh_prediction, ~] = mode(y_train_manh);
        
        % check to see if our prediction matches the validation
        % test_point_class
        if euclid_prediction == test_point_class
            euclid_kays(ind) = euclid_kays(ind) + 1;
        end
        if manh_prediction == test_point_class
            manh_kays(ind) = manh_kays(ind) + 1;
        end
        
    end
    ind = ind +1;

end

% Find error for every k value
[max_euclid kvalueindexE] = max(euclid_kays);
[max_manh kvalueindexM] = max(manh_kays);
xvalid_samples = repmat(mB,kn,1);
euclid_error = 1- (euclid_kays ./xvalid_samples);
manh_error = 1- (manh_kays ./ xvalid_samples);

% Graph the k_value vs. error rate
hold on;
plot(k_values, euclid_error);
plot(k_values, manh_error);
%xticks(k_values);
xlabel("K values");
ylabel("Error rate");
legend("Euclidean","Manhattan","Location","southeast" );
hold off;

% Euclid is the best choice
if max_euclid >= max_manh
   k = k_values(kvalueindexE);
   lnorm = 2;
else
% Manhattan is the best choice
   k = k_values(kvalueindexM);
   lnorm = 1;
end
    

end


