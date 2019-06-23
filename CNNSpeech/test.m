file='LibriSpeech/dev-clean/';
%loadAudio(file);
%processAudio(file)
load('processAudio.mat');
load('loadAudio.mat');
%processLabel(LabelCount);
load('processLabel.mat');
dataseparation(melspecCut, LabelCount,labelMatrix);
