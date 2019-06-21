function [trainM, trainL, testM, testL] = dataseparation(melspecCut, LabelCount, labelMatrix)
[row, col, totalNA]=size(melspecCut);
[numFolder,~]=size(LabelCount);
counter=1;
trainNA = round(totalNA* 0.8);
testNA = round(totalNA* 0.2);
trainM=ones(row,col,trainNA);
trainL=ones(trainNA,1);
testM=ones(row,col,testNA);
testL=ones(testNA,1);
for k=1:numFolder
    numFile=LabelCount(k,2);
    trainNum=round(numFile* 0.8);
    for t=1:numFile
        while t<=trainNum
            trainM(:,:,counter)=melspecCut(:,:,counter);
            trainL(counter,1)=labelMatrix(counter,1);
            counter=counter+1;
        end
        testM(:,:,counter)=melspecCut(:,:,couner);
        testL(counter,1)=labelMatrix(counter,1);
        counter=counter+1;
    end
end
end

