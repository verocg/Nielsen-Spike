%conversion from blackrock files to intan
%goal: generate a header file (_info.rhd) containing only the sample rate
%and an amplifier file (_amplifier.dat) containing the raw data 
%this will allow the rest of the pipeline to function normally
function TDTbin2Intan(flPath,flName)

% valid call
% TDTbin2Intan('\Users\Anita\DATA\TDT\20220105\RFmap1','RFmap1');

% output file names
%[outPath,outFile,~]=fileparts(flPath);


%% write header: only need sample rate
%this is written to be compatible with read_intan_header
%note even though this is shorter than the intan header, that function
%works (it returns empty fields for things that are not set)
%but the things before the sampleFreq need to exist

%set up tp read TDT file
dType='streams';
% read TDT info to get sample rate
data=TDTbin2mat(flPath, 'TYPE',{dType});
sampleFreq=data.streams.Wav1.fs;

hOut=fullfile(flPath,[flName '_info.rhd']);
fid=fopen(hOut, 'w');

%write magic number
magic_number= 0xC6912702;
fwrite(fid,magic_number,'uint32');

%fake file version
main_version=0;
second_version=0;
fwrite(fid,main_version,'int16');
fwrite(fid,second_version,'int16');

%sample rate
fwrite(fid,sampleFreq,'single');
fclose(fid);

%% write binary amplifier file
%intan format: int16, to convert to voltage in microvolts multiply by 0.195
dat=data.streams.Wav1.data;

hOut=fullfile(flPath,[flName '_amplifier.dat']);
fid = fopen(hOut, 'w');
fwrite(fid,dat.*1e6,'int16');
fclose(fid);

