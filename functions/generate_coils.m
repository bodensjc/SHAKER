%{
John Bodenschatz
Marquette University
Rowe Lab
04/02/2024
%}

%{
generate_coils.m takes in a given number of coils and generates sensitivity
maps assuming thay are equ-angularly spread around the subject, starting
from a given angle

INPUTS:
    reconX (int): length of x dimension of reconstructed image
    reconY (int): length of y dimension of reconstructed image
    NCoils (int): number of coils to simulate
    startAngle (double): angle at which the first coil is placed

OUTPUT:
    sensitivityMaps (double): [phantomX, phantomY, Ncoils] sized array of the
    coil sensitivity maps
%}

function sensitivityMaps = generate_coils(reconX,reconY,Ncoils,startAngle)
    delta=360/Ncoils; % change in angle from one coil to the next
    r = sqrt(reconX^2+reconY^2+1);
    [x,y]=meshgrid(-reconY/2:reconY/2-1,-reconX/2:reconX/2-1); % initialize voxel locations
    sensitivityMaps=zeros(reconY,reconX,Ncoils); % initialize data
    
    for c=1:Ncoils
        sensitivityMaps(:,:,c) = rescale(((x-r*cosd(startAngle+(c-1)*delta)).^2 + (y-r*sind(startAngle+(c-1)*delta)).^2).^(-1/2),0,1/Ncoils);
        % sensitivity is a scaled measure of 1 over the distance from 
        % voxel to the center of the coil.
    end
end