%{
John Bodenschatz
Marquette University
Rowe Lab
08/21/2024
%}

%{
template_reconstruction.m is a template for users to create their own
reconstruction algorithm


INPUTS:
    MRI (struct): MRI struct from SHAKER
    kSpace (struct): contains relevant parameters about kspace
    kSpaceTimeSeries (complex double): Time Series of kspace [kx, ky,
    coil, t]

OUTPUT:
    imageTimeSeries (complex double): Time Series of image space
%}

function imageTimeSeries = template_reconstruction(MRI,kSpace,kSpaceTimeSeries)
    imageTimeSeries = zeros(size(kSpaceTimeSeries)); % change this line to reconstruct the time series as needed
end