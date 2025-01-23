%{
John Bodenschatz
Marquette University
Rowe Lab
07/03/2023
%}

%{
kspace_Cartesian.m takes in the relevant MRI information and returns an 
array of k-space positions and the relative times at which they are measured"


INPUTS:
    MRI (struct): MRI struct from SHAKER

OUTPUT:
    kspaceTrajectory (real double): three column matrix. [kx, ky, time]
%}

function [kx, ky, timeMap] = Radial_kspace(MRI)
    accelerationFactor = MRI.AccelerationFactor;
    echoTime = MRI.EchoTime;
    rec_size = MRI.ReconstructionSize;

    nspokes = ceil(pi/2 * rec_size /accelerationFactor); % pi/2 * sampling density
    nsamp = rec_size;
    xr=[-nsamp/2:1:nsamp/2-1]';
    angles = linspace(0,180,nspokes+1);
    angles(end)=[];
    kx=zeros(nsamp,nspokes);
    ky=zeros(nsamp,nspokes);
    for m=1:nspokes
        kx(:,m) = xr*cosd(angles(m));
        ky(:,m) = xr*sind(angles(m));
    end
    % include filter option later on... 12/05/2023
    % rampdcf = 1/nspokes + (app.kx.^2 + app.ky.^2).^(0.5);


    % create time map
    eesp = MRI.eesp / 1000;
    deltaT = 1/(2*125*10^3); % bandwidth calculation. update in future version
    extras=0;
    TE=echoTime*1000;
    
    timeMap = zeros(nspokes,nsamp);
    for row = 1:nspokes
        for col = 1:nsamp
            if mod(row,2)==1
                timeMap(row,col)=(row-1)*extras*deltaT+(col-1)*deltaT+(row-1)*eesp;
            elseif mod(row,2)==0
                timeMap(row,nsamp-col+1)=(row-1)*extras*deltaT+(col-1)*deltaT+(row-1)*eesp;
            end
        end
    end
    timeMapMsec = timeMap*1000;
    init_t = TE - timeMapMsec(floor(nspokes/2)-1,nsamp); % get middle time
    timeMap = (timeMap + init_t/1000)';

end