function  classExample

%%%%%% INITAL INPUT VALUES %%%%%%%%
nhid = 3
x = [1 2 -1];
y = [1];
[input_m input_n] = size(x);
w_1 = [-1 2 2; 0 -1 3; 1 5 0];
w_2 = [0 0 1 2; -2 1 -1 1];
w_f = [4 -5 2];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp("size x: ");
size(x)
disp("size w_1: ");
size(w_1)
disp("size w_2: ");
size(w_2)
disp("size w_f: ");
size(w_f)
f = forward_prop(x,w_1, w_2)

%%%%%% Find 'a' and 'z' for hidden layers %%%%%
a_1 = w_1 * x'
z_1 = sigmoid(a_1);
% append 1 to row1
[zm zn] = size(z_1)
z_1 = [ones(zn,1); z_1];

a_2 =  w_2 * z_1;
z_2 = sigmoid(a_2)
% append 1 to row1
[zm zn] = size(z_2)
z_2 = [ones(zn,1); z_2]

a_f = w_f * z_2;
z_f = sigmoid(a_f)

%debuging
disp("a_1: ");
size(a_1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%find delta of f
delta_f = -(y-z_f)


%%%%%%% Back-Prop %%%%%%%%%
dadz_2 = delta_f * w_f';
dadz_2 = dadz_2(2:end,:);
delta_2 = sigmoid_prime( a_2) .* dadz_2

dadz_1 = delta_2' * w_2
dadz_1 = dadz_1(:,2:end);
delta_1 = sigmoid_prime(a_1) .* dadz_1'


eta = 1;
delta_wf = eta *(delta_f * z_2')
delta_w2 = eta *(delta_2 * z_1')
delta_w1 = eta *(delta_1 * x)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%









end