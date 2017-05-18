% Robert Martinez
% SID: 861238333
% CS171
% PS3

function [ w1 w2 ] = trainneuralnet( X,Y,nhid,lambda )

[m n] = size(X);
X = [ones(m,1) X];
[input_m input_n] = size(X);

%%%%%%%% Weight Dimensions %%%%%%%%%%%%%%%%%%%%
% Randomly initialize weights
% n x number of hidden units
w_1 = randn(input_n,nhid);
% number 0f hidden units+1 x 1
w_2 = randn(nhid +1,1);

%intialize ETA
eta = 0.1;
i=1;
threshold = 0.0001;

%create gridx of all Xpoints except the constants
gridx = getgridpts(X(:,2:end));

% Get inital plot of all values for grid
[gridy, ~, ~,~,~] = forward_prop([ones(size(gridx,1),1), gridx],w_1, w_2, nhid);
plotdecision(X(:,2:end),Y,gridx,gridy);
drawnow;

while 1
    %%%%%%%%%%%%% Forward Propagation %%%%%%%%%%%%
    [gridy a1 z1 w_1 w_2] = forward_prop(X,w_1, w_2, nhid);

    delta_f = (gridy - Y);
    %divide by number of samples to get the average
    delta_f = delta_f/input_m;
    
    %%%%%%%%%%%%% Back Propagation %%%%%%%%%%%%%%%%
    [delta_w1, delta_wf, max_delta] = back_prop(X,w_1, w_2, a1, z1, delta_f,lambda, eta);
    max_delta;
    
    % if the maximum delta value is less than the threshold we have
    % converged.
    if max_delta < threshold
       break 
    end
   
    % display the graph every 1,000 iterations
    if mod(i,1000)==0
       i
       [gridy, ~, ~,~,~] = forward_prop([ones(size(gridx,1),1), gridx],w_1, w_2, nhid);
        plotdecision(X(:,2:end),Y,gridx,gridy);
        drawnow;
       
    end
    
    %%% Batch update of weights weights %%%%
    w_1 = w_1 - delta_w1;
    w_2 = w_2 - delta_wf;
    
    i = i +1;
end


w1 = w_1;
w2 = w_2;


end

