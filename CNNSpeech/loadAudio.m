function [Length, Count] = loadAudio(filename)
parentd = dir (filename); % load the parent directory 
MinLength=Inf;
count=0;
subdirList=fullfile({parentd.name}');  %a cell array of all the dirctories
[numFolder, ~]=size(subdirList);
LabelCount= ones(numFolder, 2);
for k= 1:numFolder
    folderName=subdirList{k};
    subdir= append(filename, folderName);
    substruct=dir([subdir '/*.flac']); %the structure that includes all the .flac file
    numAudio = size(substruct,1);
    if numAudio>0
        LabelCount(k,1)= str2num(folderName);
        LabelCount(k,2)=numAudio;
        temp = ones(numAudio, 1);
        for c=1:numAudio
            audiofile = append(subdir,'/', substruct(c).name);
            info=audioinfo(audiofile);
            length=info.Duration;
            temp(c,1)=length;
            count=count+1;
        end
        minlength= min(temp);
        if minlength <MinLength
            MinLength=minlength;
        end 
    end 
end 
Length=MinLength;
Count=count;
LabelCount=LabelCount(3:end,:);
save ('loadAudio.mat', 'LabelCount', 'Length', 'Count', 'subdirList');

