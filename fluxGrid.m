function [mass, distance] = fluxGrid(lon,lat,lon_int,lat_int,depth,d_int,rho,SurfRadius,detector)

% -- CALCULATE MASS OF VOXELS --
% - Calculate bounds of voxel top (so the surface of the voxel) -
latbot = lat  - (lat_int/2); lattop = lat  + (lat_int/2);
lonleft = lon - (lon_int/2); lonright = lon + (lon_int/2); 

% Convert to Radians
latbot = (latbot + 90) * pi/180; % pi/180 converts degree to radian
lattop = (lattop + 90) * pi/180;
lonleft = (lonleft + 180) * pi/180;
lonright = (lonright + 180) * pi/180;

r1 = SurfRadius - (depth + (0.5.*d_int)); % top Radius (m)
r2 = SurfRadius - (depth - (0.5.*d_int)); % bottom Radius (m)

a = 1/3;
vol = ((a*r2.^3) - (a*r1.^3)).*(-cos(lattop) + cos(latbot)).*(lonright-lonleft); %m3
mass = vol.*rho; %kg



% -- CALCULATE DISTANCE TO DETECTOR --
cart_det = cart(detector(1),detector(2),detector(3));

cart_cell = cart(lon,lat,SurfRadius-depth);

% - Calculate distance - 
%   You are just finding the hyponuse but in 3-D
distance = sqrt((cart_det(1)-cart_cell(:,1)).^2 + (cart_det(2)-cart_cell(:,2)).^2 + ...
                (cart_det(3)-cart_cell(:,3)).^2); %m
