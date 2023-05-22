%--------------------------------------------------------------------------
% Orbital Mechanics Week #11 HW
% 20011336 조민형
% Input: Argument of Perigee, Inclination angle, RAAN (Degree)
% Output: Rotation martix of PQW 2 ECI
%--------------------------------------------------------------------------
function mat_rot=PQW2ECI(arg_prg,inc_angle,RAAN)

R1=[cosd(RAAN) sind(RAAN) 0;
    -sind(RAAN) cosd(RAAN) 0;
    0 0 1];
R2=[cosd(inc_angle) 0 -sind(inc_angle);
    0 1 0;
    sind(inc_angle) 0 cosd(inc_angle)];
R3=[cosd(arg_prg) sind(arg_prg) 0;
    -sind(arg_prg) cosd(arg_prg) 0;
    0 0 1];

mat_rot=(R3*R2*R1)';


end