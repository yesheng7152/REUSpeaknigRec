function y = Conv(x,W)

[wrow, wcol, numFilters] = size(W);
[xrow, xcol, ~         ] = size(x);

yrow = xrow - wrow + 1;
ycol = xcol - wcol + 1;

y = zeros(yrow,ycol,numFilters);

for k = 1:numFilters
    filter =W(:, :, k); % currently a 28*28 matrix with a k value associated with it 
    filter = rot90(squeeze(filter), 2); %squeezing it remove the k value from the matrix, only a 28*28 matrix 
    y(:, :, k) =conv2(x, filter, 'valid'); %valid means the filter does not reach oooooutside the x 
end
end
