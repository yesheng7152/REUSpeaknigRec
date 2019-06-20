function [Length, Count] = loadAudio(filename)
parentd = dir (filename); % load the parent directory 
MinLength=Inf;
count=1;
subdirList=fullfile({parentd.name}');  %a cell array of all the dirctories
[numFolder, ~]=size(subdirList);
y= ones(numFolder, 1);
for k= 1:numFolder
    subdir= append(filename, subdirList{k});
    substruct=dir([subdir '/*.flac']); %the structure that includes all the .flac file
    numAudio = size(substruct,1);
    if numAudio>0
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


