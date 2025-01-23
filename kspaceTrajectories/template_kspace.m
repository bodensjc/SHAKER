%{
John Bodenschatz
Marquette University
Rowe Lab
08/21/2024
%}

%{
template_kspace.m is a template for users to create their own kspace
trajectory function.


INPUTS:
    MRI (struct): MRI struct from SHAKER

OUTPUT:
    kspaceTrajectory (real double): three column matrix. [kx, ky, timeMap]
%}

function [kx, ky, timeMap] = template(MRI)
    [kx, ky] = meshgrid(1:MRI.Re,1:96); % generate your kx, ky values
    kx = kx(:); ky = ky(:); % vectorize them
    timeMap = 50*ones(len(kx),1); % create timeMap vector
end