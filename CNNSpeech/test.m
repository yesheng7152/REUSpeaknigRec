file='LibriSpeech/dev-clean/';
%loadAudio(file);
%processAudio(file)
load('processAudio.mat');
load('loadAudio.mat');
label=processLabel(LabelCount);
matrixL=melspecCut(1,141,:);
matrixL=reshape(matrixL, 1, 2703);
matrixL=rot90(matrixL,3);
c= label == matrixL;
sum(c)