%--------------------------------------------------------------------------
% Orbital Mechanics Week #12 HW-1
% 20011336 조민형
% Input: Semi-major axis (km), Eccentricity, True anomaly (deg)
% Output: Range in Perifocal frame
%--------------------------------------------------------------------------

function rangeInPQW=solveRangeInPerifocalFrame(semimajor_axis,eccentricity,true_anomaly)

a=semimajor_axis;
e=eccentricity; 
nu=true_anomaly; %deg
p=a*(1-e)^2;
r=p/(1+e*cosd(nu));

rangeInPQW=[r*cosd(nu);r*sind(nu);0];

end
