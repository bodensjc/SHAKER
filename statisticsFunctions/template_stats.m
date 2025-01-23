%{
John Bodenschatz
Marquette University
Rowe Lab
08/21/2024
%}

%{
template_stats.m is a template for users to create their own statistical
analysis tools

INPUTS:
    dataTS (complex double): 4-D array [Ix, Iy, coils, time] of fmri task
        experiment. can be kspace/image or complex/real
    design (logical vector): 1s and 0s same length as 3rd dimension of
        kspaceTS. 1s => task.
    MRI (struct): MRI struct from SHAKER

OUTPUT:
    statmap (real double): [Ix, Iy] map of t-values at each voxel 
%}

function statmap = template_stats(dataTS,design,MRI)
    nx = size(imageTS,1); ny = size(imageTS,2);
    statmap = zeros(nx, ny); % work with this
end