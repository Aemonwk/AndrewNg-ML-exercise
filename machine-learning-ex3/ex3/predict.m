function p = predict(Theta1, Theta2, X)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)

% Useful values
m = size(X, 1);
num_labels = size(Theta2, 1);

% You need to return the following variables correctly 
p = zeros(size(X, 1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Complete the following code to make predictions using
%               your learned neural network. You should set p to a 
%               vector containing labels between 1 to num_labels.
%
% Hint: The max function might come in useful. In particular, the max
%       function can also return the index of the max element, for more
%       information see 'help max'. If your examples are in rows, then, you
%       can use max(A, [], 2) to obtain the max for each row.
%



% Z2 = Theta1*a1; % (25*401)*?401*1?= 25 * 1
% 
% a2 = sigmoid(Z2); % 25*1
% 
% a2 = [1;a2];% 26*1
% 
% Z3 = Theta2*a2; % ?10*26? * ?26*1? = 10 * 1
% 
% p = sigmoid(Z3);% 10 * 1


X = [ones(m,1) X];

prob1 = sigmoid(X * Theta1');

prob1 = [ones(m,1) prob1];

prob2 = sigmoid(prob1 * Theta2' );

[z,p] = max (prob2,[],2);
    



% =========================================================================


end