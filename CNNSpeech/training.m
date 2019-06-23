function idk = training(trainM, trainL)
layers = [
    imageInputLayer([32 140 1])
    
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
end

