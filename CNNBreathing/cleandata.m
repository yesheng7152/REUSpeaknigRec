datafolder= 'english';
ads=audioDatastore(datafolder,...
    'IncludeSubfolders',true,...
    'FileExtensions','.ogg',...
    'LabelSource', 'foldernames');
[length,~]=size(ads.Files);
for k=1:length
    info=audioinfo(ads.Files{k});
    ads.Labels(k)={info.Artist};
    fwl{k,1}=ads.Files{k};
    fwl{k,2}=info.Artist;
end
