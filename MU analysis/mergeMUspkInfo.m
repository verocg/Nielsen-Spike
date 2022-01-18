function mergeMUspkInfo(filepath,animalID,unitID,expID,probeID,startID,stopID)

%this function merges all MU spike files into one file for further analysis
%output structure contains spiketimes and channel info as well as
%info on cooccuring spikes
%
%input:
%filepath: path to the animal folder (e.g.., Z:\EphysNew\Data)
% animalID - animal ID (string)
% unitID - unit ID (string)
% expID - experiment ID (string)
%probeID: probe id
%startID: start job ID
%stopID: stop job ID

wb=waitbar(0,'Merging MUspkinfo');

expname=[animalID '_u' unitID '_' expID];

for i=startID:stopID
    waitbar((i-startID)/(stopID-startID),wb);
   
    %load file
    fname=fullfile(filepath,animalID,expname,'SpikeFiles',[expname '_j' num2str(i) '_p' num2str(probeID) '_MUspkinfo']);           
    load(fname); %generates spk
    
    %output
    if i==startID
        MUspkMerge.spktimes=spk.spkTimesDet;
        MUspkMerge.detCh=spk.detCh;
        MUspkMerge.detChSort=spk.detChSort;
        MUspkMerge.flagDuplicate=spk.flagDuplicate;
        MUspkMerge.NDuplicate=spk.NDuplicate;
        MUspkMerge.jobId=ones(size(spk.spkTimesDet))*i;
        MUspkMerge.duplicateMxCh=spk.duplicateMxCh;
        MUspkMerge.duplicateMxIdx=spk.duplicateMxIdx;
    else
        MUspkMerge.spktimes=[MUspkMerge.spktimes spk.spkTimesDet];
        MUspkMerge.detCh=[MUspkMerge.detCh spk.detCh];
        MUspkMerge.detChSort=[MUspkMerge.detChSort spk.detChSort];
        MUspkMerge.flagDuplicate=[MUspkMerge.flagDuplicate spk.flagDuplicate];
        MUspkMerge.NDuplicate=[MUspkMerge.NDuplicate spk.NDuplicate];
        MUspkMerge.jobId=[MUspkMerge.jobId ones(size(spk.spkTimesDet))*i];
        
        %merging of duplicate channels and idx requires expansion of
        %matrices to make things fit
        nRowIn=size(spk.duplicateMxCh,1);
        nRowOut=size(MUspkMerge.duplicateMxCh,1);
        if nRowIn>nRowOut
            MUspkMerge.duplicateMxCh(nRowIn,:)=0;
            MUspkMerge.duplicateMxIdx(nRowIn,:)=0;
        end
        if nRowIn<nRowOut
            spk.duplicateMxCh(nRowOut,:)=0;
            spk.duplicateMxIdx(nRowOut,:)=0;
        end
        MUspkMerge.duplicateMxCh=[MUspkMerge.duplicateMxCh spk.duplicateMxCh];
        MUspkMerge.duplicateMxIdx=[MUspkMerge.duplicateMxIdx spk.duplicateMxIdx];
        
    end
    clear spk;
end

save(fullfile(filepath,animalID,expname,[expname '_p' num2str(probeID) '_MUspkMerge']),'MUspkMerge'); 
close(wb);