%problem set 2, part b 

%% initialize

Qm=0.045; %w/m2
k=2.5; %W/(m-k)
kappa= 1e-6; %m2/s
zmax=400; %m
dz=5; %m
z=0:dz:zmax; %depth array
tmax= (3600*24*365)*91; %40 years, in seconds
dt=3600*24*365; % time step of one year, in seconds
t=0:dt:tmax; %time array
T0=-10; %temperature at half-space boundary prior to it being elevated
Ts=-6; %temperature at half-space boundary after it has been elevated
Tzero=zeros(size(z));

eta=z./(2*(sqrt(kappa*tmax)));
%theta=(T-T0)/(Ts-T0);
%theta=erfc(eta);
T=erfc(eta)*(Ts-T0)+T0+0.025*z;  %% Marko added the geotherm here, instead of trying to add it to T0


  figure(1)
plot(T,z,'r')
 xlabel('Temperature (°C)','fontname','arial','fontsize',21)
     ylabel('Depth (m)','fontname','arial','fontsize',21)
     set(gca,'fontsize',18,'fontname','arial')
     set(gca,'YDIR','reverse')
     pause(0.1)


% mess with my variables, and match it to data/model

