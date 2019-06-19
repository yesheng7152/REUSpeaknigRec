while exist('Images', 'var')==0
    run('TestMnistConv.m');

end
X = Images(:, :, 8001:10000); %the testing set images
D = Labels(8001:10000); %the testing set labels
load('MnistConv.mat');
prompt = 'Which image would you like to choose? Please enter number between 1 to 2000: ';
k= input (prompt);
while k>2001 || k<1
    prompt = 'Which image would you like to choose? Please enter INTEGER BETWEEN 1 to 2000: ';
    k=input(prompt); 
end 
fprintf('the image you choose is:');
display(D(k));
    x = X(:, :, k);
    y1= Conv(x,W1);
    y2 = ReLU(y1);
    y3 = Pool(y2);
    y4 = reshape(y3, [],1);  % the feature extracting process
    v5 = W5*y4;
    y5 = ReLU(v5); % after the hidden layer
    v = Wo*y5;
    y = Softmax(v); % y is a vector that contains the guess 
figure
display_network(x(:));
title('Input Image')
    
    [~,i] = max(y); % get the guess 
    fprintf ('the computer guess the image is:');
    disp (i);
    
    