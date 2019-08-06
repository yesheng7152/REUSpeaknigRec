%side function to generate audios of specific length from one audio file
% name of audio file that needs to be cut
filename='Fake1(11by2).ogg';
[y,fs]=audioread(filename);
n=length(y(:,1));
i=1;
%number 5 here is to represent the length of new audio files in seconds,
%can be changed 
for k =1:(5*fs):n
    cutoff= k+(5*fs);
    % continue cutting the original file until the end 
    if cutoff<n 
        samples=[k,cutoff];
        [y1,fs]=audioread(filename,samples);
        %name the new audio file this 
        newfilename= "Fake1_" + k +".ogg";
        audiowrite(newfilename,y1,fs);
        i=i+1;
    end
end