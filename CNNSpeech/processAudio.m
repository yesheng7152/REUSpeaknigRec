function matrixes= processAudio(filename)
parentd = dir (filename); % load the parent directory 
subdirList=fullfile({parentd.name}');  %a cell array of all the dirctories
[numFolder, ~]=size(subdirList);
melspecCut = ones(32, 141, 2703); % recieved from loadAudio
count=1;
for k= 1:numFolder %going through each folder
    subdir= append(filename, subdirList{k});
    substruct=dir([subdir '/*.flac']); %the structure that includes all the .flac file
    numAudio = size(substruct,1);
    if numAudio>0
        for c=1:numAudio %going through each audio file
            audiofile = append(subdir,'/', substruct(c).name);
            info=audioinfo(audiofile);
            [audioIn, fs]=audioread(info.Filename); % information need for melspectrogram
            melspec=melSpectrogram(audioIn, fs); % matrix for melspetrogram
            mel2=melspec(:,1:141); %cutting it at 1.4 second (what we got for shortest time)
            melspecCut(:,:,count)=melspecCut(:,:, count).*mel2; %update the total file 
            melspecCut(1,141,count)=str2num(subdirList{k}); %labeling the spectrogram
            count=count+1; %update count for
        end
    end 
end

save('processAudio.mat', 'melspecCut'); % save the total matrix 

