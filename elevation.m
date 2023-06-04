%--------------------------------------------------------------------------
% Orbital Mechanics Week #13 HW-3
% 20011336 조민형
% Input: ENU [E N U] (m), Elevation Mask Angle (deg) 
% Output: Elevation angle (deg)
%--------------------------------------------------------------------------

function el=elevation(ENU,el_mask)

el=atan2d(ENU(:,3),sqrt(ENU(:,1).^2+ENU(:,2).^2));

el(el(:,1)<=el_mask,1)=nan;
el=el';


end