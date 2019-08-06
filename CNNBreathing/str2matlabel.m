% Side function to coverted letter label into number matrix of 0 and 1s if
% needed for prediction combination in the future. 
function [labelmatrix] = str2matlabel(inputlabel)
[numInput, ~]=size(inputlabel);
labels=unique(inputlabel);
[numLabel,~]=size(labels);
list=reshape(labels,1,numLabel);
horep=repmat(list,numInput,1);
horep=cellstr(horep);

verep=repmat(inputlabel,1,numLabel);
verep=cellstr(verep);
labelmatrix=strcmp(horep,verep);
end

