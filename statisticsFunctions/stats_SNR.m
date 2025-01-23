%{
John Bodenschatz
Marquette University
Rowe Lab
04/18/2023
%}

%{
stats_SNR.m takes in a time series of fmri image data, a task indication 
vector, and performs a t-test on the average task image against the average
non-task image to determine activation

INPUTS:
    dataTS (complex double): 4-D array [nx, ny, coils, time] of fmri task
        experiment. can be kspace/image or complex/real
    design (logical vector): 1s and 0s same length as 3rd dimension of
        kspaceTS. 1s => task.
    MRI (struct): MRI struct from SHAKER

OUTPUT:
    SNRmap (real double): [nx, ny]  
%}

function SNRmap = stats_SNR(dataTS,design,MRI)
    nx = size(dataTS,1); ny = size(dataTS,2);

    % separate into task/nontask images, average across coils
    restImages=squeeze(mean(dataTS(:,:,:,design==0),3));
    taskImages=squeeze(mean(dataTS(:,:,:,design==1),3));

    TaskRest=0; % currently set to calclate the SNR of all images.
    % can be changed to do only one or the other!
    if TaskRest == 0
        restMean = squeeze(mean(restImages,3));
        SNRmap = restMean./sqrt(var(restImages,0,3));
    elseif TaskRest == 1
        taskMean = squeeze(mean(taskImages,3));
        SNRmap = taskMean./sqrt(var(taskImages,0,3));
    elseif TaskRest == 2
        coilavgd = squeeze(mean(dataTS,3));
        meanImg = squeeze(mean(coilavgd,3));
        SNRmap = meanImg./sqrt(var(coilavgd,0,3));
    end
end
