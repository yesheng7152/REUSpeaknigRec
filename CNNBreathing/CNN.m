function[trainedNet]=CNN(imageSize,XTrain,YTrain,XValidation,YValidation,XTest,YTest,augimdsTrain,labels)
%% Set Up 
%number of output,filter size for max-pooling at the end
% drop out rate, number of filters
numClasses = numel(categories(YTrain));
timePoolSize = ceil(imageSize(2)/8);
dropoutProb = 0.2;
numF = 25;

%% Declare layers
layers = [
    imageInputLayer(imageSize)
    %3*3 area 25 filters
    convolution2dLayer(3,numF,'Padding','same')
    batchNormalizationLayer
    reluLayer
    %maxPooling 3*3 
    maxPooling2dLayer(3,'Stride',2,'Padding','same')
    
    %3*3 area 50 filters
    convolution2dLayer(3,2*numF,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(3,'Stride',2,'Padding','same')
    
    %3*3 area 100 filters
    convolution2dLayer(3,4*numF,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(3,'Stride',2,'Padding','same')
    
    %3*3 area 100 filters
    convolution2dLayer(3,4*numF,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer([1 timePoolSize])

    dropoutLayer(dropoutProb)
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer
    ];

%% Training option 
%validation data is for cross validation
miniBatchSize = 128;
validationFrequency = 1;
options = trainingOptions('adam', ...
    'InitialLearnRate',1e-3, ...
    'MaxEpochs',40, ...
    'MiniBatchSize',miniBatchSize, ...
    'Shuffle','every-epoch', ...
    'Plots','training-progress', ...
    'Verbose',false, ...
    'ValidationData',{XValidation,YValidation}, ...
    'ValidationFrequency',validationFrequency, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropFactor',0.1, ...
    'LearnRateDropPeriod',30);

%% Train the network 
trainedNet = trainNetwork(augimdsTrain,layers,options);

%% Results 
YValPred = classify(trainedNet,XValidation);
validationError = mean(YValPred ~= YValidation);
YTrainPred = classify(trainedNet,XTrain);
trainError = mean(YTrainPred ~= YTrain);
YTestPred = classify(trainedNet,XTest);
testError = mean(YTestPred ~= YTest);
disp("Training error: " + trainError*100 + "%")
disp("Validation error: " + validationError*100 + "%")
disp("Test error: " + testError*100 +"%")

%% Confusion Matrix for validation and test data
figure('Units','normalized','Position',[0.2 0.2 0.5 0.5]);
cm = confusionchart(YValidation,YValPred);
cm.Title = 'Confusion Matrix for Validation Data';
cm.ColumnSummary = 'column-normalized';
cm.RowSummary = 'row-normalized';
sortClasses(cm, labels)


figure('Units','normalized','Position',[0.2 0.2 0.5 0.5]);
cm = confusionchart(YTest,YTestPred);
cm.Title = 'Confusion Matrix for Test Data';
cm.ColumnSummary = 'column-normalized';
cm.RowSummary = 'row-normalized';
sortClasses(cm, labels)
end