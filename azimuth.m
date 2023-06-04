%--------------------------------------------------------------------------
% Orbital Mechanics Week #13 HW-2
% 20011336 조민형
% Input: ENU vector [E N U] (m)
% Output: Azimuth angle (deg)
%--------------------------------------------------------------------------

function az=azimuth(ENU)

az=atan2d(ENU(:,1),ENU(:,2));
az(az(:,1)<0,1)=az(az(:,1)<0,1)+360;

az=az';
end