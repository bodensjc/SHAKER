%{
John Bodenschatz
Marquette University
Rowe Lab
08/21/2024
%}

%{
template_SigEq.m is a template for users to create their own
signal equation


INPUTS:
    M0 (real double): proton spin density map
    T2star (real double): T2star map
    T1 (real double): T1 map
    deltaB (real double): magnetic field inhomogeneity map
    kSpace (struct): contains relevant parameters about kspace
    MRI (struct): MRI struct from SHAKER

OUTPUT:
    kspace (complex double): simulated kspace from M0 and other details
%}

function kspace = template_SigEq(M0,T1,T2star,deltaB,kSpace,MRI)
    coilSensitivity = MRI.CoilSensitivities;
    kx = kSpace.kX; ky = kSpace.kY;

    % get kspace array size, initialize empty array
    nCoils = size(coilSensitivity,3);
    kspace_size = size(kx);
    kspace = zeros(size(kx,1),size(kx,2),nCoils);

    % build up kspace array per coil
    for c=1:nCoils
        kspaceC = zeros(kspace_size); % change this line to fill in k-space as desired
        kspace(:,:,c)=kspaceC;
    end
end