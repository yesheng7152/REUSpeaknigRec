%loading
datafolder='LibriSpeech/dev-clean';
ads=audioDatastore(datafolder,...
    'IncludeSubfolders',true,...
    'FileExtensions','.flac',...
    'LabelSource','foldernames');
ads0=copy(ads);

countEachLabel(ads);
LabelCount=countEachLabel(ads);
labels=categorical((rot90(LabelCount{:,1})));
%split Data into Training, Validation, and Test Sets

[adsTrain,adsValidation,adsTest]=splitdata(ads);

%compute speech spectrograms
segmentDuration=1.4;
frameDuration=0.015;
hopDuration = 0.010;
numBands=40;

epsil=1e-6;
XTrain=speechSpectrograms(adsTrain,segmentDuration,frameDuration,hopDuration,numBands);
XTrain=log10(XTrain+epsil);

XValidation = speechSpectrograms(adsValidation,segmentDuration,frameDuration,hopDuration,numBands);
XValidation = log10(XValidation + epsil);

XTest = speechSpectrograms(adsTest,segmentDuration,frameDuration,hopDuration,numBands);
XTest = log10(XTest + epsil);

YTrain = adsTrain.Labels;
YValidation = adsValidation.Labels;
YTest = adsTest.Labels;

%{ 
Show three data's graph
specMin = min(XTrain(:));
specMax = max(XTrain(:));
idx = randperm(size(XTrain,4),3);
figure('Units','normalized','Position',[0.2 0.2 0.6 0.6]);
for i = 1:3
    [x,fs] = audioread(adsTrain.Files{idx(i)});
    subplot(2,3,i)
    plot(x)
    axis tight
    title(string(adsTrain.Labels(idx(i))))

    subplot(2,3,i+3)
    spect = XTrain(:,:,1,idx(i));
    pcolor(spect)
    caxis([specMin+2 specMax])
    shading flat

    sound(x,fs)
    pause(2)
end

%}
%{
Show normal distribution
figure
histogram(XTrain,'EdgeColor','none','Normalization','pdf')
axis tight
ax = gca;
ax.YScale = 'log';
xlabel("Input Pixel Value")
ylabel("Probability Density")
%}
%add data Augmentation 

sz = size(XTrain);
specSize = sz(1:2);
imageSize = [specSize 1];
augmenter = imageDataAugmenter( ...
    'RandXTranslation',[-10 10], ...
    'RandXScale',[0.8 1.2], ...
    'FillValue',log10(epsil));
augimdsTrain = augmentedImageDatastore(imageSize,XTrain,YTrain, ...
    'DataAugmentation',augmenter);

save('setup.mat');