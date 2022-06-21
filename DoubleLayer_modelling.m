%This script serves for the OECT capacitance modelling%
%Trial script for bilayer modelling%
%Last Edit Date: 2022/06/07

%Initialization%
clc;clear all; close all;

%%Bilyaer Model%%
%Variable definition%
f = (10^-1):0.1:10^6;
w = 2*pi*f; %Angular frequency
Cch = 100e-9; %Initial Capacitance of channel side/gate side/bilayer
Ri =1000; % Initial Internal and bilayer Resistance
Cg = [10*Cch, Cch];
Rb = [26, 10, 1e3, 100e3];
%Channel Modelling%
for i = 1: length(Cg)
    Cb = 0.1*Cg(i);
    figure
    Uch_b = (1./(j*w*Cch))./((1./(j*w*Cg(i)))+(1./(j*w*Cb+1./Rb(1)))+Ri+(1./(j*w*Cch)));
    semilogx(f,Uch_b,'black','LineStyle','-');title('Bilayer Capacitance Plot');xlabel('f (Hz)');ylabel('U_c_h');
    hold on
    Uch_b = (1./(j*w*Cch))./((1./(j*w*Cg(i)))+(1./(j*w*Cb+1./Rb(2)))+Ri+(1./(j*w*Cch)));
    semilogx(f,Uch_b,'black','LineStyle','-.');
    hold on
    Uch_b = (1./(j*w*Cch))./((1./(j*w*Cg(i)))+(1./(j*w*Cb+1./Rb(3)))+Ri+(1./(j*w*Cch)));
    semilogx(f,Uch_b,'black','LineStyle','--');
    hold on
    Uch_b = (1./(j*w*Cch))./((1./(j*w*Cg(i)))+(1./(j*w*Cb+1./Rb(4)))+Ri+(1./(j*w*Cch)));
    semilogx(f,Uch_b,'black','LineStyle',':'); ylim([0 1])
end


%%Mesh Plotting%%
%Variable definition%
f_Mesh = 10; %Can be changed to any other frequency
w_Mesh = 2*pi*f_Mesh; %Angular frequency
Cch = 100e-9; %Capacitance of channel side
Ri =1000; %Internal Resistance
R_g2Ch = 10^-1 :0.1: 10^2; %Truncated the 10^2 to 10^3 part
Rb_M = 10:10:10^6; % The step size will affect the initial phase
Rdu_M2 = []; dU_M2 = [];
for i = 1:length(R_g2Ch)
    Cg_e = Cch * R_g2Ch(i);Cb_e = 0.1*Cg_e;
    Uch_ref = (1./(1*w_Mesh*Cch))./((1./(1*w_Mesh*Cg_e))+(1./(1*w_Mesh*Cb_e+1./26))+Ri+(1./(1*w_Mesh*Cch)));
    for k = 1:length(Rb_M)
        Uch_Rb = (1./(1*w_Mesh*Cch))./((1./(1*w_Mesh*Cg_e))+(1./(1*w_Mesh*Cb_e+1./Rb_M(k)))+Ri+(1./(1*w_Mesh*Cch)));
        dU_M2(k) = Uch_ref - Uch_Rb;
    end
    Rdu_M2(i,:) = dU_M2;

end
Rdu_M2 = Rdu_M2.';
figure
mesh(R_g2Ch,Rb_M,Rdu_M2);set(gca,'xscale','log');set(gca,'yscale','log');
xlabel("C_g/C_c_h");ylabel("R_b");zlabel("Maximum Response");title("Mesh Plot of ΔU")

