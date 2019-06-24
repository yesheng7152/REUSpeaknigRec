function [adsTrain,adsValidation,adsTest] = splitdata(ads)
files = ads.Files;
LabelCount=countEachLabel(ads);
[numFolder,~]=size(LabelCount);
counter=1;
trainIndex=1;
validationIndex=1;
testIndex=1;
for k=1:numFolder
    numFile=LabelCount{k,2};
    TrainNum=round((numFile *0.6));
    RestNum=numFile-TrainNum;
    ValidationNum=round((RestNum*0.5));
    t=1;
    while t<=numFile
        while t<=TrainNum
          % disp(t);
         %  disp(numFile);
         %  disp('training loop');
         %  disp(counter);
            filesTrain(trainIndex,:)=files(counter,:);
            counter=counter+1;
            trainIndex=trainIndex+1;
            t=t+1;
        end
        while t<=(TrainNum+ValidationNum)
        % disp('testing loop');
         %disp(counter)
        filesValidation(validationIndex,:)=files(counter,:);
        counter=counter+1;
        t=t+1;
        validationIndex=validationIndex+1;
        end
        filesTest(testIndex,:)=files(counter,:);
        counter=counter+1;
        t=t+1;
        testIndex=testIndex+1;

    end
    
end 
filesTest=ismember(ads.Files,filesTest);
filesValidation=ismember(ads.Files,filesValidation);
filesTrain=ismember(ads.Files,filesTrain);
adsTest = subset(ads,filesTest);
adsValidation = subset(ads,filesValidation);
adsTrain=subset(ads,filesTrain);
end

