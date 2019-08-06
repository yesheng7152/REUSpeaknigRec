%% Set up the data 
%lode data
load('dataseparated.mat');
sz = size(trainM);
specSize = sz(1:2);
imageSize = [specSize 1];
%transform the train to prevent overfitting 
augmenter = imageDataAugmenter( ...
    'RandXTranslation',[-10 10], ...
    'RandXScale',[0.8 1.2], ...
    'FillValue',log10(epsil));
augimdsTrain = augmentedImageDatastore(imageSize,trainM,trainL, ...
    'DataAugmentation',augmenter);
%% Layer setup
layers = [
    imageInputLayer(imageSize)
    
    convolution2dLayer(4,8, 'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(40)
    softmaxLayer
    classificationLayer];
%% Training Options
options = trainingOptions('sgdm',...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',30,...
    'Shuffle','every-epoch', ...
    'ValidationData',testSet, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress');
%% Training the Network 
net = trainNetwork(trainSet,layers,options);
   

