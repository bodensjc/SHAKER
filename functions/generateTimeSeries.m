%{
John Bodenschatz
Marquette University
Rowe Lab
2/29/24
%}

%{
generateTimeSeries.m takes in a kspace with and without activation,
relevant task  design info (HRF, epochs, etc.) and noise stats to return a
complete timem series data ksapce.

INPUTS:
    kspaceR (complex double): rest state kspace image
    kspaceT (complex double): task state kspace image
    nEpochs (integer): number of epochs
    nRest (integer): number of rest state immages per epoch
    nTask (integer): number of task state images per epoch
    sigma (double): st dev of real and imaginary noise for fourier space

OUTPUT:
    kspaceTS (complex double): time series of kspace arrays
%}

function kspaceTS = generateTimeSeries(kspaceR,kspaceT,design,sigma)
    %initialRestBlock=repmat(kspaceR,1,1,1,initialRest);
    %restBlock=repmat(kspaceR,1,1,1,nRest);
    %taskBlock=repmat(kspaceT,1,1,1,nTask);
    %singleBlock=cat(4,taskBlock,restBlock);
    %kspaceTS=repmat(singleBlock,1,1,1,nEpochs);
    %kspaceTS = cat(4,initialRestBlock,kspaceTS);
    %{
    kspaceRestReal = real(kspaceR)'
    kspaceRestImag = imag(kspaceR);
    kspaceTaskReal = real(kspaceT);
    kspaceTaskImag = imag(kspaceT);
    design = cat(1,zeros(initialRest,1),repmat([ones(nTask,1);zeros(nRest,1)],nEpochs,1));
    %}



    % kspaceR/T is like rho/theta (true)
    % add noise to get r/phi (measured)

    [x,y,c] = size(kspaceR);
    kspaceTS = zeros(x,y,c,length(design));

    %x = s .* randn(dim) + v;
    %y = s .* randn(dim);
    %r = sqrt(x.^2 + y.^2);


    for j=1:size(kspaceTS,4)
        if design(j)==0
            kspaceTS(:,:,:,j) = kspaceR;
        elseif design(j)==1
            kspaceTS(:,:,:,j) = kspaceT;
        end
    end

    kspaceTS = kspaceTS + (sigma*randn(size(kspaceTS)) + sigma*randn(size(kspaceTS))*sqrt(-1))/c;
    

    %beta0 = abs(kspaceR);
    
end