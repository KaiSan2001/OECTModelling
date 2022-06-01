%This script serves for the OECT capacitance modelling%
%Start Date: 2022/05/30
%Last Edit Date: 2022/05/30

%Initialization%
clc;clear all; close all;


%Variable definition%
f = (10^-1):10^6;
w = 2*pi*f; %frequency
Cch = 100e-9; Cg = Cch; Cb = 10;
Rb = 10; Ri =1000;

%Loop calculation%
Uch = [];
for i=1:length(w)
    %U = (1/(j*w(i)*Cch))/(1/(j*w(i)*Cg) + 1/(w(i)*Cb+1/Rb) + Ri + 1/(j*w(i)*Cch));
    U = (1/(j*w(i)*Cch))/(1/(j*w(i)*Cg)+1/(j*w(i)*Cch)+Ri);
    Uch(end+1) = U;
end

figure
semilogx(f,Uch);title('trial');xlabel('f(Hz)');ylabel('Uch');