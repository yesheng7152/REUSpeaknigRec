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
trainindex=1;
testindex=1;
for k=1:numFolder
    numFile=LabelCount(k,2);
    trainNum=round(numFile* 0.8);
    t=1;
    while t<=numFile
        while t<=trainNum
          % disp(t);
         %  disp(numFile);
         %  disp('training loop');
         %  disp(counter);
            trainM(:,:,trainindex)=melspecCut(:,:,counter);
            trainL(trainindex,1)=labelMatrix(counter,1);
            counter=counter+1;
            trainindex=trainindex+1;
            t=t+1;
        end
        % disp('testing loop');
         %disp(counter);
        testM(:,:,testindex)=melspecCut(:,:,counter);
        testL(testindex,1)=labelMatrix(counter,1);
        counter=counter+1;
        t=t+1;
        testindex=testindex+1;
    end
end 
testM = testM(:,:,1:(testNA-1));
testL=testL(1:(testNA-1),:);
save ('dataseparated.mat','testM','testL','trainM','trainL');
end

