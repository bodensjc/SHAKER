%{
John Bodenschatz
Marquette University
Rowe Lab
12/05/2023
%}

%{
InversionRecovery_SigEq.m returns the simulated kspace given relevant MRI info
    and kspace sampling points.

    INVERSION RECOVERY

INPUTS:
    M0 (real double): proton spin density map
    T1 (real double): T1 map
    deltaB (real double): magnetic field inhomogeneity map
    kSpace (struct): contains relevant parameters about kspace
    MRI (struct): contains relevant parameters from the MRI simulator

OUTPUT:
    kspace (complex double): simulated kspace from M0 and other details
%}

function kspace = InversionRecovery_SigEq(M0,T1,T2,deltaB,kSpace,MRI)
    gamma = MRI.gamma; % 42 MHz/T (H nuclei gyromagnetic ratio)
    TR=MRI.RepititionTime;
    i=sqrt(-1); % imaginary unit
    coilSensitivity = MRI.CoilSensitivities;

    kx = kSpace.kX; ky = kSpace.kY;

    TI = MRI.EchoTime; % temprorary fix... I guess 8/12/2024

    % vectorize kspace
    nCoils = size(coilSensitivity,3);
    kspace_size = size(kx);
    kspace=zeros(size(kx,1),size(kx,2),nCoils);
    kxx=kx(:); kyy=ky(:);
    numKpts = length(kxx);
   
    
    img_length=length(M0);
    [x, y] = meshgrid(linspace(0,1,img_length),linspace(0,1,img_length));

    for c=1:nCoils
        % build the integrand of signal equation
        ksp = @(j) coilSensitivity(:,:,c).*M0.*(1-2*exp(-TI./T1)+exp(-TR./T1)).*...
            exp(-i*2*pi*(kxx(j)*x+kyy(j)*y));
        if MRI.IncludeB0Inhomogeneity
            ksp =@(j) ksp(j).*exp(i*gamma*deltaB); % time map??? 3/1/2024
        end
    
        kspaceC=zeros(numKpts,1);
        for j=1:numKpts
            kspaceC(j) = sum(ksp(j),'all');
        end
        kspaceC = reshape(kspaceC,kspace_size);
        kspace(:,:,c)=kspaceC;
    end
end