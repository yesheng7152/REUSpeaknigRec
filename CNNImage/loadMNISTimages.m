function images = loadMnistImages(filename)

fp = fopen(filename, 'rb'); %not a text file so rb
assert(fp ~= -1, ['Could not open ', filename, '']);
magic = fread(fp, 1, 'int32', 0, 'ieee-be'); %reading fp into magic
assert(magic == 2051, ['bad magic number in', filename, '']);
numImages = fread(fp, 1, 'int32', 0, 'ieee-be');
numRows = fread(fp, 1, 'int32', 0, 'ieee-be');
numCols = fread(fp, 1, 'int32', 0, 'ieee-be');
images = fread(fp, inf, 'unsigned char=>unsigned char');
images = reshape(images, numCols, numRows, numImages);
images = permute(images,[2 1 3]);
fclose(fp);

images = reshape(images, size(images, 1)* size(images, 2), size(images, 3));
images = double(images)/255;

end 