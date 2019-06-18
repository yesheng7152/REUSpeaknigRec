function images = loadMnistImages(filename)

fp = fopen(filename, 'rb'); %not a text file so rb
assert(fp ~= -1, ['Could not open ', filename, '']);
magic = fread(fp, 1, 'int32', 0, 'ieee-be'); % read one line because of '1', and reads the magic number
assert(magic == 2051, ['bad magic number in', filename, '']);
numImages = fread(fp, 1, 'int32', 0, 'ieee-be'); % read the number of image which is 10000
numRows = fread(fp, 1, 'int32', 0, 'ieee-be'); % read the number of rows 28
numCols = fread(fp, 1, 'int32', 0, 'ieee-be'); % reads the number of cols 28
images = fread(fp, inf, 'unsigned char'); % reads all the pix of images
images = reshape(images, numCols, numRows, numImages); % 2*2 matrixs with 10000 of them
images = permute(images,[2 1 3]); % switch the col with rows, now like looks like the actual images
fclose(fp); %close

images = double(images)/255; % all values between 0 and 1

end 
