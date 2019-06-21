file='LibriSpeech/dev-clean/';
loadAudio(file);
processAudio(file)
load('processAudio.mat');
load('loadAudio.mat');

spec= melspecCut(:,:,1);
size(spec)