function [imageSize,XTrain,YTrain,XValidation,YValidation,XTest,YTest,augimdsTrain,labels]=setup(filename)
%% Process Data
%audio files is been converted to audioDatastore provided by audio ToolBox
datafolder=filename;
ads=audioDatastore(datafolder,...
    'IncludeSubfolders',true,...
    'FileExtensions','.ogg',...
    'LabelSource','foldernames');
countEachLabel(ads);
LabelCount=countEachLabel(ads);
labels=categorical((rot90(LabelCount{:,1})));

%% Data Split
%split Data into Training, Validation, and Test Sets

[adsTrain,adsValidation,adsTest]=splitdata(ads);

%% Spectrogram Computation 
%Set up 
info=audioinfo(adsTrain.Files{1});
duration=round(info.Duration);
segmentDuration=duration;
frameDuration=0.01;
hopDuration = 0.010;
numBands=30;
epsil=1e-6; %bias

%converstion 
XTrain=speechSpectrograms(adsTrain,segmentDuration,frameDuration,hopDuration,numBands);
XTrain=log10(XTrain+epsil);

XValidation = speechSpectrograms(adsValidation,segmentDuration,frameDuration,hopDuration,numBands);
XValidation = log10(XValidation + epsil);

XTest = speechSpectrograms(adsTest,segmentDuration,frameDuration,hopDuration,numBands);
XTest = log10(XTest + epsil);

%% Set up labels 
YTrain = adsTrain.Labels;
YValidation = adsValidation.Labels;
YTest = adsTest.Labels;

%{
%% Show three data's graph
specMin = min(XTrain(:));
specMax = max(XTrain(:));
idx = size(XTrain,4);
figure('Units','normalized','Position',[0.2 0.2 0.6 0.6]);
for i = 1:idx
    i
    [x,fs] = audioread(adsTrain.Files{i});
    subplot(2,idx,i)
    plot(x)
    axis tight
    title(string(adsTrain.Labels(i)))

    subplot(2,idx,i+idx)
    spect = XTrain(:,:,1,i);
    pcolor(spect)
    caxis([specMin+2 specMax])
    shading flat

    sound(x,fs)
    pause(2)
end
%}

%% Transform the Training Set to pervent overfitting 
sz = size(XTrain);
specSize = sz(1:2);
imageSize = [specSize 1];
augmenter = imageDataAugmenter( ...
    'RandXTranslation',[-10 10], ...
    'RandXScale',[0.8 1.2], ...
    'FillValue',log10(epsil));
augimdsTrain = augmentedImageDatastore(imageSize,XTrain,YTrain, ...
    'DataAugmentation',augmenter);

%% Save the data
save('setup.mat');