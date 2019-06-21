function labelMatrix = processLabel(LabelCount)
labelM=LabelCount(3:end,:) %get ride of the first 2 none number rows
[numFolder, ~]=size(labelM); % get the number of folders
totalAudio= sum(labelM(:,2)); %get the number of total audio files
labelMatrix=zeros(totalAudio,1); %declare a totalaudio*1 matrix
count=1;
for c=1:numFolder
    foldername=labelM(c,1)
    numAudio=labelM(c,2);
    for k=1:numAudio
        labelMatrix(count,1)=foldername;
        count=count+1;
    end
end
end


