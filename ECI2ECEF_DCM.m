%--------------------------------------------------------------------------
% Orbital Mechanics Week #13 HW-1
% 20011336 조민형
% Input: Time [YYYY MM DD hh mm ss]
% Output: dcm of eci2ecef
%--------------------------------------------------------------------------

function DCM=ECI2ECEF_DCM(time)
dt=datetime(time);
jd=juliandate(dt);
theta_g0=siderealTime(jd);

DCM=[cos(theta_g0) sin(theta_g0) 0;
    -sin(theta_g0) cos(theta_g0) 0;
    0 0 1];


end