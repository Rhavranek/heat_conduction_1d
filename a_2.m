%% Initialize

%depth array
zmax=400; %m
dz=5;
z=(dz/2):dz:zmax-(dz/2); 
N=length(z); 

%variables
k=2.5; %w/(m-k)
rho=2000; %kg/m3
Cp=2000; %J/kg K %rough approximation

%time array
nyears=92;
tmax=(3600*24*365)*nyears; %40 years, in seconds
ndays=20; %kdt/dz^2 has to be less than 0.5 for it to run
dt=(3600*24)*ndays; %time step of one year
t=0:dt:tmax; %creates an array of time steps (time)



%% Part C - Cape Thompson Data

load cape_thompson_copy.dat;
zdata=cape_thompson_copy(:,1);
Tdata=cape_thompson_copy(:,2);

%find the slope of the data at depth
zlast=zdata(end);
Tlast=Tdata(end);
slope=diff(Tdata)./diff(zdata); %gives to the slope of ALL data points
dTdz_data=mean(slope(end-10:end)); % gives slope for last 10 points m
Told=Tlast -(dTdz_data*zlast); %solves eq for the intercept, b=told, tlast/zlast are x and y
T0_data=Told+(dTdz_data*zdata);


%% Model

%set-up the numerical solution
Q=zeros(N,1); %creates an array of zeros 
T=zeros(N,1);%creats an array of zero - we want this line so we have something it can change
dTdz0=dTdz_data;%original slope
T=Told+(dTdz0*z);% this line fills the T array with temps and depth
T0=T; 
Ts=-5.2; %new surface temp -- messed with this, trial and error to make it look good.
dTdz(N)=dTdz_data; %prescribed heat flux at the bottom in K/m, same as data

imax=length(t); %loop goes every time step
nplots=100; %so we only see 100 plots, and not every time
tplot=tmax/nplots; %the amount of time between each plot 

%% LOOP
for i=1:imax

T(1)=Ts;%degrees C, has to be the new surface temp

dTdz(1:N-1) = diff(T)/dz; %% we have it be 1:N-1 because we want node 0 have the heat flux we know...
%and we want dT/dz to be dictated by Q at the base. 

%calculate heat flux
Q = -k*dTdz;

%rate of change of T
dQdz = diff(Q)/dz;

%update T
%T = T - dQdz*dt; % take all the values of T and subtract dQdz(so you're subtracting 2 nodes from 3)
T(2:N) = T(2:N)-(1/(rho*Cp))*dQdz*dt;

if(rem(t(i),tplot)==0)  
figure(1)
     plot(T,z,'k')
     hold on
     plot(T0,z,'r')
     plot(Tdata,zdata,'ko') %'ko' makes black circles
     
     xlabel('Temperature (°C)','fontname','arial','fontsize',21)
     ylabel('Depth (m)','fontname','arial','fontsize',21)
     set(gca,'fontsize',18,'fontname','arial')
     set(gca,'YDIR','reverse')
     pause(0.1)
     hold off
end
end

%%You can mess with time steps, temp change on top 
%% Chi^2 test

xq=zeros(N,1);
Tmod=interp1(z,T,zdata);%the first variable is the x of the model, second is the y of the model, and lastly...
%is where we want to program to interpolate to (the data points)
chi2=(Tdata-Tmod).^2

%(Tobs-Tmodel)^2 -- the smaller the number the better
%interpolate beteween two model points to get a point at a data point
%interp1



