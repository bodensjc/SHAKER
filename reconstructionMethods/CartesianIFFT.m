%{
John Bodenschatz
Marquette University
Rowe Lab
09/09/2023
%}

%{
CartesianIFFT.m takes in fmri time series k-space data and uses the
standard inverser foureir transform to reconstruct images.


INPUTS:
    MRI (struct): MRI struct from SHAKER
    kSpace (struct): contains relevant parameters about kspace
    kSpaceTimeSeries (complex double): Time Series of kspace [kx, ky,
    coil, t]

OUTPUT:
    imageTimeSeries (complex double): Time Series of image space
%}

function imageTimeSeries = CartesianIFFT(MRI,kSpace,kSpaceTimeSeries)
    imageTimeSeries = ifftshift(ifft2(fftshift(kSpaceTimeSeries)),4);
end