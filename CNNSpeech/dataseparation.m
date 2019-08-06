function [trainSet,testSet] = dataseparation(melspecCut, LabelCount, labelMatrix)
[row, col, totalNA]=size(melspecCut);
[numFolder,~]=size(LabelCount);
counter=1;
%data split, 80% 20%
trainNA = round(totalNA* 0.8);
testNA = round(totalNA* 0.2);
%3D matrix for data and 2d matrix for labels
trainM=ones(row,col,trainNA);
trainL=ones(trainNA,1);
testM=ones(row,col,testNA);
testL=ones(testNA,1);
trainindex=1;
testindex=1;
%separating the data 
for k=1:numFolder
    numFile=LabelCount(k,2);
    trainNum=round(numFile* 0.8);
    t=1;
    while t<=numFile
        while t<=trainNum
            trainM(:,:,trainindex)=melspecCut(:,:,counter);
            trainL(trainindex,1)=labelMatrix(counter,1);
            counter=counter+1;
            trainindex=trainindex+1;
            t=t+1;
        end
        testM(:,:,testindex)=melspecCut(:,:,counter);
        testL(testindex,1)=labelMatrix(counter,1);
        counter=counter+1;
        t=t+1;
        testindex=testindex+1;
    end
end 
testM = testM(:,:,1:(testNA-1));
testL=testL(1:(testNA-1),:);
testSet={testM,testL};
trainSet={trainM,trainL};
save ('dataseparated.mat');
end

