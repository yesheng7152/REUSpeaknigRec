function [W1, W5, Wo] = MnistConv(W1, W5, Wo, X, D)

alpha = 0.01; % the percent of the error effect the update the weight
beta = 0.95; % the percent of the old weight effect the update the weight

momentum1 = zeros(size(W1));
momentum5 = zeros(size(W5));
momentumo = zeros(size(Wo));

N = length(D); % number of labels/images

bsize = 100;
blist = 1:bsize:(N-bsize+1); % list of 1  to N-100+1(7901) increment by 100

for batch = 1:length(blist) % for each batch(100 images) we have new dW1, dW5 and dWo, total of 80 batches 
    dW1 = zeros(size(W1));
    dW5 = zeros(size(W5));
    dWo = zeros(size(Wo));
    
    begin = blist(batch); 
    for k = begin:begin+bsize-1 % going through each of the 100 images in the batch
        
        x = X(:, :, k); % x the kth images, so the x is one 28*28 matrix
        y1 = Conv(x, W1); % y1 is 20 of 20*20 matrix, for x after conv layer
        y2 = ReLU(y1);
        y3 = Pool(y2); % 10*10 matrix 20 of them for each x
        y4 = reshape(y3, [], 1); % covert into a 2000*1 matrix, 2000 rows 
        v5 = W5*y4; % apply the weight for the hidden layer, 100 rows
        y5 = ReLU(v5); 
        v = Wo*y5; % apply the output weight, 10 rows 
        y = Softmax(v); % to clearly see the guessed number
        
        d = zeros(10,1); % an empty of 10*1
        d(sub2ind(size(d), D(k), 1)) = 1; % find the index of the labeled value, then set that index to 1
        % to indicate the correct value
        
        
        
        e = d-y; %error = actual(d)-guess(y)
        delta =e;% delta = error from the 10 nodes
        e5 = Wo' * delta; % swap row and columns of Wo, perform matrix multiplication, 100 rows (error for the 100 nodes)
        delta5 = (y5 > 0) .* e5; % if element is greater than 0 change it to the corresponding element in e5 
        % y5 transformed into a 100*1 matrix of only 1 and 0 (true and
        % false) then multiply by the e5 (element by element)
        % delta = error for the 100 nodes after adjust for zeros
        e4 = W5' * delta5;  % calculating the error for filters, which is 2000 
        e3 = reshape(e4, size(y3)); % make them into 10*10 matrix of 20, each matrix is error
        e2 = zeros(size(y2)); % set 20 of 20*20 matrix all 0
        W3 = ones(size(y2))/(2*2); % 20 of  20*20 matrix all 0.25
        
        for c =1:20
            e2(:, :, c) = kron(e3(:, :, c), ones([2 2])) .* W3(:, :, c);
            % each element of e3 is turn into a 2*2 matrix, and them
            % together to make a 20*20 matrix, then times each by .25.
            % Currently e2 is 20 of 20*20 matrix 
        end 
        
        delta2 = (y2 > 0) .* e2; % adjust error for the layer right before pooling layer
        
        delta1_x = zeros(size(W1)); % 20 9*9 matrix of 0s 
        
        for c =1:20
            delta1_x(:, :, c) = conv2(x(:, :), rot90(delta2(:, :, c),2), 'valid');
            % errors for each of the filters 
        end 
        
        dW1 = dW1 + delta1_x;   % add up all the error for each of the 100 images
        dW5 = dW5 + delta5*y4';
        dWo = dWo + delta*y5';
    end 
    
    dW1 = dW1 / bsize;  % all the error divided by the size of the batch 
    dW5 = dW5 / bsize;  % aka the average of the errors
    dWo = dWo / bsize;
    
    momentum1 = alpha*dW1 +beta*momentum1; % update the weights, for 80times 
    W1 = W1 + momentum1;
    
    momentum5 = alpha*dW5 + beta*momentum5;
    W5 = W5 + momentum5;
    
    momentumo = alpha*dWo + beta*momentumo;
    Wo = Wo + momentumo;
end 
end 