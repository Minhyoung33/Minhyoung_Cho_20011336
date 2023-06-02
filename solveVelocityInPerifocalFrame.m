%--------------------------------------------------------------------------
% Orbital Mechanics Week #12 HW-2
% 20011336 조민형
% Input: Semi-major axis (km), Eccentricity, True anomaly (deg)
% Output: Velocity in Perifocal frame
%--------------------------------------------------------------------------

function velocityInPQW=solveVelocityInPerifocalFrame(semimajor_axis,eccentricity,true_anomaly)

a=semimajor_axis;
e=eccentricity; 
nu=true_anomaly; %deg
mu=3.986004418*10^5; %km^3/s^2
p=a*(1-e^2); %km

velocityInPQW=sqrt(mu/p).*[-sind(nu);e+cosd(nu);0];

end
