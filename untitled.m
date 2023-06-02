load nu_GPS.mat;
nu_QZSS=nu;
sc=satelliteScenario(datetime(nav.GPS.toc),datetime([2023 04 30 00 00 00]),1);
gps=satellite(sc,nav.GPS.a,nav.GPS.e,nav.GPS.i,nav.GPS.OMEGA,nav.GPS.omega,nu(1));
% qzss=satellite(sc,nav.QZSS.a,nav.QZSS.e,nav.QZSS.i,nav.QZSS.OMEGA,nav.QZSS.omega,nu_QZSS(1));
gs=groundStation(sc,37.55,127.1);
ac=access(gps,gs);
intvls=accessIntervals(ac);
play(sc)

