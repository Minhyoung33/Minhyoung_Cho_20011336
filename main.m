% cd 'C:\Users\jomin\OneDrive - Sejong University\개인\세종대학교\4학년\우주궤도역학\Term Project Module 2';
load nav.mat;
nav_GPS=[nav.GPS.a;nav.GPS.e;nav.GPS.i;nav.GPS.omega;nav.GPS.M0;cal2time(nav.GPS.toc);nav.GPS.OMEGA];
nav_QZSS=[nav.QZSS.a;nav.QZSS.e;nav.QZSS.i;nav.QZSS.omega;nav.QZSS.M0;cal2time(nav.QZSS.toc);nav.QZSS.OMEGA];
nav_BDS=[nav.BDS.a;nav.BDS.e;nav.BDS.i;nav.BDS.omega;nav.BDS.M0;cal2time(nav.BDS.toc);nav.BDS.OMEGA];
nav_sat=[[1;nav_GPS] [2;nav_QZSS] [3;nav_BDS]]';

save nav_sat nav_sat;
[PQW_GPS,ECI_GPS,ENU_GPS,ECEF_GPS,LLH_GPS]=cal_sat_pos(nav_sat(1,:));
[PQW_QZSS,ECI_QZSS,ENU_QZSS,ECEF_QZSS,LLH_QZSS]=cal_sat_pos(nav_sat(2,:));
[PQW_BDS,ECI_BDS,ENU_BDS,ECEF_BDS,LLH_BDS]=cal_sat_pos(nav_sat(3,:));
Pos.GPS.PQW=PQW_GPS;
Pos.GPS.ECI=ECI_GPS;
Pos.GPS.ENU=ENU_GPS;
Pos.GPS.ECEF=ECEF_GPS;
Pos.GPS.LLH=LLH_GPS;

Pos.QZSS.PQW=PQW_QZSS; 
Pos.QZSS.ECI=ECI_QZSS;
Pos.QZSS.ENU=ENU_QZSS;
Pos.QZSS.ECEF=ECEF_QZSS;
Pos.QZSS.LLH=LLH_QZSS;

Pos.BDS.PQW=PQW_BDS;
Pos.BDS.ECI=ECI_BDS;
Pos.BDS.ENU=ENU_BDS;
Pos.BDS.ECEF=ECEF_BDS;
Pos.BDS.LLH=LLH_BDS;
save Pos Pos;
clear;
Term_app
















function [pos_PQW, pos_ECI, pos_ENU, pos_ECEF, pos_LLH]=cal_sat_pos(sat_nav)
grav=3.986004418*10^14;
dt=[sat_nav(7):1:(sat_nav(7)+3600*24)]'-sat_nav(7);
rotmat=PQW2ECI(rad2deg(sat_nav(5)),rad2deg(sat_nav(4)),rad2deg(sat_nav(8)));
M_k=sat_nav(6)+sqrt(grav/sat_nav(2).^3).*dt;
E_initial=0;
E_k=nan(size(dt,1),1);

for i=1:size(dt,1)
    while 1
        E_k(i,1)=M_k(i)+sat_nav(3).*sin(E_initial);
        E_diff=abs(E_k(i,1)-E_initial);
        if E_diff<10^(-13)
            break;
        end
        E_initial=E_k(i,1);
    end
end
E_k(E_k<0)=E_k(E_k<0)+2*pi;
E_k(E_k>2*pi)=E_k(E_k>2*pi)-2*pi;
nu=atan2((sqrt(1-sat_nav(3).^2).*sin(E_k))./(1-sat_nav(3).*cos(E_k)),(cos(E_k)-sat_nav(3))./(1-sat_nav(3).*cos(E_k)));
% save nu nu;
pos_ENU=nan(size(dt,1),3);
pos_ECEF=nan(size(dt,1),3);

date=time2cal(sat_nav(7)+dt);
pos_PQW=solveRangeInPerifocalFrame(sat_nav(2),sat_nav(3),rad2deg(nu));
pos_ECI=(rotmat*pos_PQW(:,1:3)')';
dcm=dcmeci2ecef('IAU-2000/2006',date);
for i=1:size(dt,1)
    pos_ECEF(i,:)=(dcm(:,:,i)*pos_ECI(i,1:3)')';
end

pos_LLH=ecef2lla(pos_ECEF(:,1:3));
idx=find(diff(pos_LLH(:,2))<-300);
pos_LLH(idx+1:end,2)=pos_LLH(idx+1:end,2)+360;
end