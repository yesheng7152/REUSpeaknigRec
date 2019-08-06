file='LibriSpeech/dev-clean/';
%ran the two commented out functions the first time 
loadAudio(file);
processAudio(file)
load('processAudio.mat');
load('loadAudio.mat');
label=processLabel(LabelCount);
matrixL=melspecCut(1,141,:);
matrixL=reshape(matrixL, 1, 2703);
matrixL=rot90(matrixL,3);
c= label == matrixL;
sum(c) %should equal to the total number of audio file in the directory