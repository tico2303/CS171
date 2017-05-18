% Robert Martinez
% SID: 861238333
% CS171
% PS3

function [ delta_w1 delta_wf max_delta] = back_prop( X, w_1,w_f,a_1,z_1, delta_f,lambda, eta )

%%%%%%% Back-Prop %%%%%%%%%
dadz_1 = delta_f * w_f';
dadz_1 = dadz_1(:,2:end);
delta_1 = sigmoid_prime( a_1) .* dadz_1;

%constructing change in weights matrices
deltawf =  z_1' * delta_f;
deltaw1 =  X' * delta_1;

% return max delta to determine convergence
max_delta = max(max( max(deltawf),max(deltaw1) ));

% regularization
deltawf = deltawf + (-eta * 2 * lambda * deltawf);
deltaw1 = deltaw1 + (-eta * 2 * lambda * deltaw1);

delta_wf = deltawf;
delta_w1 = deltaw1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





end

