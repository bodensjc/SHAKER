%{
John Bodenschatz
Marquette University
Rowe Lab
06/26/2023
%}

%{
getnoise.m Takes a given image and signal to noise ratio (SNR) then returns
           the scale parameter of a Rayleigh distribution that can be used
           to generate noise in k-space. The scale parameter, sigma, of the
           Rayleigh dist. is the standard deviation of the related
           bivariate normal distribution.

INPUTS:
    IMG (real/complex double): Image-space representation of object 
    SNR (real double): desired SNR

OUTPUT:
    getnoise (real double): Rayleigh dist. scale parameter sigma
%}

function getnoise = getnoise(IMG,SNR)
    IMG = abs(IMG);
    %mask=IMG>0;
    mask = (IMG./max(IMG,[],'all')) > (1/10); % 1/10 kind of arbitrary...
    % get mean of signal region, sum of nonzero pixels / count
    IMGMean = sum(mask.*IMG,'all') ./ sum(mask~=0,'all');
    % image space stats
    RayleighMean = IMGMean / SNR; %/(SNR+1);
    RayleighSigma = RayleighMean / sqrt(pi/2);
    NormalVar = RayleighSigma^2;
    % k-space stats, scale image space by dimensions
    getnoise = prod(size(IMG),'all') * NormalVar;
end
