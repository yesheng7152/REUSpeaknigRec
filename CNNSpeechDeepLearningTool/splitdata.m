function [adsTrain,adsValidation,adsTest] = splitdata(ads)
% A list of files 
files = ads.Files;
% A table with the name of folder and the numble of files in the according folder
LabelCount=countEachLabel(ads);
[numFolder,~]=size(LabelCount);
%variable set up
counter=1;
trainIndex=1;
validationIndex=1;
testIndex=1;
%looping through all the folders
for k=1:numFolder
    %getting the number of files in the folder
    numFile=LabelCount{k,2};
    %get the number of traning files
    TrainNum=round((numFile *0.6));
    RestNum=numFile-TrainNum;
    %half of the rest are the validations, the other half is testing
    ValidationNum=round((RestNum*0.5));
    %reset t to 0 for every folder
    t=1;
    %looping though all the files in the folder
    while t<=numFile
        %getting the training files
        while t<=TrainNum
            filesTrain(trainIndex,:)=files(counter,:);
            counter=counter+1;
            trainIndex=trainIndex+1;
            t=t+1;
        end
        %getting the validation files
        while t<=(TrainNum+ValidationNum)
        filesValidation(validationIndex,:)=files(counter,:);
        counter=counter+1;
        t=t+1;
        validationIndex=validationIndex+1;
        end
        %setting the testing files
        filesTest(testIndex,:)=files(counter,:);
        counter=counter+1;
        t=t+1;
        testIndex=testIndex+1;
    end
    
end 
%a list of boolean values to see if the files are in the total list of
%files
filesTest=ismember(ads.Files,filesTest);
filesValidation=ismember(ads.Files,filesValidation);
filesTrain=ismember(ads.Files,filesTrain);

%getting the audiodatastore into test,validation, and train sets
adsTest = subset(ads,filesTest);
adsValidation = subset(ads,filesValidation);
adsTrain=subset(ads,filesTrain);
end

