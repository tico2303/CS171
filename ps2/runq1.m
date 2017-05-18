%Robert Martinez
% SID: 861238333
% cs171
% PS2

function runq1
x = importdata('phishing.dat');
[m n] = size(x);
one_vect = ones(m, 1);
x = [one_vect x];
[m n] = size(x);
y = x(:,end);
x = x(:,1:n-1);
%%%%%%%%%%% Quadratic augmented feature set %%%%%%%%%%%%%
quad_x = x;
[m n] = size(x);
for i=2:n;
    for j=i:n;
        new_quad_feature1 = x(:,i).*x(:,j);
        quad_x = [quad_x new_quad_feature1];
    end
end

%%%% Split into test and train
[mq nq] = size(quad_x);
test_quad= quad_x(1:m/5,:);
train_quad = quad_x((m/5)+1:end,:);
y_test = y(1:m/5,:);
y_train = y((m/5)+1:end,:);


%%%%%%%%%%% Linear Model %%%%%%%%%%%%%%%%%
test_lin = x(1:m/5,:);
train_lin = x((m/5)+1:end,:);



% try lambdas in a logrithmic scale
ls = logspace(-1,3,20);
% [%accuracy, 1(lin) 2(quad), lambda-value]
best_accuracy = [0 0 0];

for l=ls
    % train the weights on both models
    w_lin = learnlogreg(train_lin,y_train,l);
    w_quad = learnlogreg(train_quad, y_train, l);
   
    % get results of test prediction 
    lin_res = test_lin * w_lin;
    quad_res = test_quad * w_quad;
    
    % quad_y will contain a value greater that 0 if correct
    % and less than 0 if incorrect
    quad_y = y_test .* quad_res;
    lin_y = y_test .* lin_res;

    %calculate accuracy
    quad_accuracy = sum(quad_y > 0);
    quad_accuracy = quad_accuracy ./size(quad_y,1);
    
    lin_accuracy = sum(lin_y > 0);
    lin_accuracy = lin_accuracy ./size(lin_y,1);
 
    %check if any accuracies are better than the best
    if quad_accuracy > best_accuracy(:,1)
        best_accuracy(:,1) = quad_accuracy;
        best_accuracy(:,2) = 2;
        best_accuracy(:,3) = l;
    end
    if lin_accuracy > best_accuracy(:,1)
        best_accuracy(:,1) = lin_accuracy;
        best_accuracy(:,2) = 1;
        best_accuracy(:,3) = l;
    end
    disp("Current Best:")
    disp(best_accuracy);
   
end
disp("Final Best Accuracy");
disp(best_accuracy);

end

