%1/20 class notes
%ex. of FCTS diffusion model

N=3; %number of nodes
dz = 10.0; %m
dt= 1; %seconds
k=2; %W/mK
T = zeros(N,1);%size of the matrix, rows first, columns second
rho=2000; %kg/m3
Cp=2000; %J/kg K %rough approximation
T(1)=-10; %brrr! -10 C %node one will be surface temperature, and that's what we'll mess with
%we need an array of heat flux that is three elements long
%check out class notes for a drawing of where our heat flux nodes are. We
%chose the heat flux at the bottom as our Qo
dTdz=zeros(N,1);
dTdz(N)= 0.025; %an array of temp/distance steps K/m
Q(N)=0.04; %W/m2 influx

%Put following in loop
%calculate T gradient

%dTdz=diff(T)/dz; %if we have this line of code, it'll override our last dTdz code...
% and we want to have a line that keeps our last box

dTdz(1:N-1) = diff(T)/dz;

%calculate heat flux
Q = -k*dTdz;

%rate of change of T

dQdz = diff(Q)/dz;

%update T
%T = T - dQdz*dt; % take all the values of T and subtract dQdz(so you're subtracting 2 nodes from 3)
T(2:N) = T(2:N)-(1/(rho*Cp))*dQdz*dt;

%to load a file do load "filename"
%first column zData
%second column TData


