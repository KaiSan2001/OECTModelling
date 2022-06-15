%Delta_U Meshwork Plotting%
%Variable definition%
clc;clear all;close all;
f_Mesh = 10; %Can be changed to any other frequency
w_Mesh = 2*pi*f_Mesh; %Angular frequency
Cch = 100e-9; %Capacitance of channel side
Ri =1000; %Internal Resistance
R_g2Ch = 10^-1 :0.1: 10^3;
R_gs2g = 1:-(10^-2):10^-2;
Rdu = [];
dU = []; %Create an empty array to store the delta U
for i = 1: length(R_g2Ch)
    Cg = Cch * R_g2Ch(i); % Put it here to reduce the computation burden
    for k = 1:length(R_gs2g)
        Cgs = Cg * R_gs2g(k);
        Uch_reference = (1./(1*w_Mesh*Cch))./(1./(1*w_Mesh*Cg)+1./(1*w_Mesh*Cch)+Ri);
        Uch_gs = (1./(1*w_Mesh*Cch))./(1./(1*w_Mesh*Cgs)+1./(1*w_Mesh*Cch)+Ri);
        dU(k) = Uch_reference - Uch_gs;
    end
    RdU(i,:)=dU;
    
end
RdU = RdU.';
figure
mesh(R_g2Ch,R_gs2g,RdU);set(gca,'xscale','log');set(gca,'yscale','log');set(gca,'YDir','reverse');
xlabel("C_g/C_c_h");ylabel("C_g_,_s/C_g");zlabel("ΔU");title("Mesh Plot of ΔU")
