%{
John Bodenschatz
Marquette University
Rowe Lab
04/18/2023
%}

%{
stats_ttest.m takes in a time series of fmri image data, a task indication 
vector, and performs a t-test on the average task image against the average
non-task image to determine activation

INPUTS:
    dataTS (complex double): 4-D array [nx, ny, coils, time] of fmri task
        experiment. can be kspace/image or complex/real
    design (logical vector): 1s and 0s same length as 3rd dimension of
        kspaceTS. 1s => task.
    MRI (struct): MRI struct from SHAKER

OUTPUT:
    tmap (real double): [nx, ny] map of t-values at each voxel 
%}

function tmap = stats_ttest(dataTS,design,MRI)
    nx = size(dataTS,1); ny = size(dataTS,2);
    tmap = zeros(nx, ny);

    %optional masking to remove small t values
    %mask = zeros(nx, ny);
    %mask_threshold = (0.3)*max(max(mean(abs(imageTS),3)));

    % separate into task/nontask images, coil avg
    restImages=squeeze(mean(dataTS(:,:,:,design==0),3));
    taskImages=squeeze(mean(dataTS(:,:,:,design==1),3));
    restMean = squeeze(mean(mean(restImages,4),3));
        
    for jj=1:nx
        for kk=1:ny
            [h,p,ci,stats] = ttest(taskImages(jj,kk,:),restMean(jj,kk),'Tail','right');
            tmap(jj,kk) = abs(stats.tstat);
            %mask(jj,kk) = mean(abs(reconstructed_images(jj,kk,:))) > mask_threshold;
        end
    end
end
