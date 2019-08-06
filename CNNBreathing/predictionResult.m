
%% Train the nueral network for breathing and speech 

[bimageSize,bXTrain,bYTrain,bXValidation,bYValidation,bXTest,bYTest,baugimdsTrain]=setup('breathOnly');
bTrainedNet=CNN(bimageSize,bXTrain,bYTrain,bXValidation,bYValidation,bXTest,bYTest,baugimdsTrain);

[simageSize,sXTrain,sYTrain,sXValidation,sYValidation,sXTest,sYTest,saugimdsTrain]=setup('speechOnly');
sTrainedNet=CNN(simageSize,sXTrain,sYTrain,sXValidation,sYValidation,sXTest,sYTest,saugimdsTrain);

TrainLabel=cat(1,str2matlabel(bYTrain),str2matlabel(bYValidation));
TestLabel=str2matlabel(bYTest);
%prediction result for breathing and speech 
breathTrainPredict=cat(1,predict(bTrainedNet,bXTrain),predict(bTrainedNet,bXValidation));
breathTestPredict=predict(bTrainedNet,bXTest);

speechTrainPredict=cat(1,predict(sTrainedNet,sXTrain),predict(sTrainedNet,sXValidation));
speechTestPredict=predict(sTrainedNet,sXTest);

%% Train the Nueral network for artificial data
[imageSize,XTrain,YTrain,XValidation,YValidation,XTest,YTest,augimdsTrain,labels]=setup('2by11');
TrainedNet=CNN(imageSize,XTrain,YTrain,XValidation,YValidation,XTest,YTest,augimdsTrain,labels);





