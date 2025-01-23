%{
John Bodenschatz
Marquette University
Rowe Lab
06/26/2023
%}

%{
sigmaFromCNRandB1.m takes a user-defined contrast to noise ratio (CNR) and
Beta1 value (task activation voxel increase) and calculates the necessary
sigma for the normal noise to add to the image

INPUTS:
    IMG (real/complex double): Image-space representation of object 
    SNR (real double): desired SNR

OUTPUT:
    getnoise (real double): Rayleigh dist. scale parameter sigma
%}

function getnoise = getnoise(IMG,SNR)

end
