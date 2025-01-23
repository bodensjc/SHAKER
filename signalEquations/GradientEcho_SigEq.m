%{
John Bodenschatz
Marquette University
Rowe Lab
10/19/2023
%}

%{
GradientEcho_SigEq.m returns the simulated kspace given relevant MRI info
    and kspace sampling points. Using Equation (9)* from the paper
    "Incorporating Relaxivities..."

    GRADIENT ECHO (MAIN FMRI)

INPUTS:
    M0 (real double): proton spin density map
    T2star (real double): T2star map
    T1 (real double): T1 map
    deltaB (real double): magnetic field inhomogeneity map
    kSpace (struct): contains relevant parameters about kspace
    MRI (struct): contains relevant parameters from the MRI simulator

OUTPUT:
    kspace (complex double): simulated kspace from M0 and other details
%}

function kspace = GradientEcho_SigEq(M0,T1,T2star,deltaB,kSpace,MRI)
    i=sqrt(-1); % imaginary unit    
    gamma = MRI.gamma; % 42 MHz/T (H nuclei gyromagnetic ratio)
    flipAngle=MRI.FlipAngle;
    TR=MRI.RepititionTime;
    coilSensitivity = MRI.CoilSensitivities;
    kx = kSpace.kX; ky = kSpace.kY;
    timeMap = kSpace.timeMap;


    % vectorize kspace
    nCoils = size(coilSensitivity,3);
    kspace_size = size(kx);
    kspace=zeros(size(kx,1),size(kx,2),nCoils);
    kxx=kx(:); kyy=ky(:);
    numKpts = length(kxx);
    timeMap = timeMap(:);
    
    if prod(size(timeMap),'all')==1 % if just TE is given instead of a map
        timeMap = repmat(timeMap,numKpts,1);
    end

    img_length=length(M0);
    [x, y] = meshgrid(linspace(0,1,img_length),linspace(0,1,img_length));


    for c=1:nCoils
        % build the integrand of signal equation
        ksp = @(j) coilSensitivity(:,:,c).*M0.*(1-exp(-TR./T1)).*exp(-timeMap(j)./T2star).*...
            (sind(flipAngle)./(1-cosd(flipAngle)*exp(-TR./T1))).*...
            exp(-i*2*pi*(kxx(j)*x+kyy(j)*y));
        if MRI.IncludeB0Inhomogeneity
            ksp =@(j) ksp(j).*exp(i*gamma*deltaB*timeMap(j));
        end
    
        kspaceC=zeros(numKpts,1);
        for j=1:numKpts
            kspaceC(j) = sum(ksp(j),'all');
        end
        kspaceC = reshape(kspaceC,kspace_size);
        kspace(:,:,c)=kspaceC;
    end
end