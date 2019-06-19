Images = loadMNISTimages ('MNIST/t10k-images-idx3-ubyte');

Labels = loadMNISTLabels('MNIST/t10k-labels-idx1-ubyte');
Labels(Labels == 0) = 10; % change the 0 to 10 in the vector;

rng(1); % seed the randomnizer 

W1 = 1e-2*randn([9 9 20]);
W5 = (2*rand(100,2000)-1)*sqrt(6) / sqrt(360+2000);
Wo = (2*rand(10, 100)-1)*sqrt(6)/sqrt(10+100);

X = Images(:, :, 1:8000);
D = Labels(1:8000);

for epoch = 1:3 % number of times the traning happens with the same X and D
    epoch
    [W1, W5, Wo] = MnistConv(W1, W5, Wo, X, D); % traning process
end

save('MnistConv.mat'); % saves the weights 

X = Images(:, :, 8001:10000); % the other 2000 images
D = Labels(8001:10000); %the rest 2000 labels 
acc = 0;
N = length(D);

for k =1:N
    x = X(:, :, k);
    y1= Conv(x,W1);
    y2 = ReLU(y1);
    y3 = Pool(y2);
    y4 = reshape(y3, [],1);  % the feature extracting process
    v5 = W5*y4;
    y5 = ReLU(v5); % after the hidden layer
    v = Wo*y5;
    y = Softmax(v); % y is a vector that contains the guess 
    
    [~,i] = max(y); % get the guess 
    if i ==D(k)     % check the guess 
        acc = acc+1;    % accuracy increment 
    end
end
acc = acc/N;        % provide the accuracy percentage 
fprintf('Accuracy is %f\n', acc);

