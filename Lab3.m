close all; clear; clc;
NACA = '0006';
alpha1 = 10; % AOA [deg]
%% Experimental Data
Exp006Data = load("Dataset Reynolds 9E8.csv"); % NACA 0006 (section aoa [deg], section C_L)
Exp012Data = load("Dataset 9E6 Reynolds.csv"); % NACA 0012 (section aoa [deg], section C_L)


 %% 1.1.1 Plotting for comparing airfoils
 [a1, c_l1, x1,y_camber1,x_u1,y_u1,x_L1,y_L1] = plotAirfoil('0021',100);
 [a2, c_l2, x2,y_camber2,x_u2,y_u2,x_L2,y_L2] = plotAirfoil('2421',100);
figure('Position', [40 60 700 400]); hold on; grid on;
title("Comparing NACA Airfoils")
xlabel("Distance along Chord");
ylabel("Thickness");
plot(x_u1,y_u1,'r.','LineWidth',2);
plot(x_L1,y_L1,'r.','LineWidth',2);
plot(x_u2,y_u2,'b.','LineWidth',2);
plot(x_L2,y_L2,'b.','LineWidth',2);
plot(x2, y_camber2,'b');
ylim([-0.2 0.3])
xlim([-0.001 1.001])
legend("NACA 0021","","NACA 2421","","NACA 2421 Camber")

%% Finding true steady state value for c_l convergence
[~,~,~,~,x_u,y_u,x_L,y_L] = plotAirfoil(NACA,2000);
x_B = [flip(x_L(2:end)),x_u(1:end)];
y_B = [flip(y_L(2:end)),y_u(1:end)];
C_l_true = Vortex_Panel(x_B,y_B,alpha1);

% figure(); hold on;
% x_B_new = x_B;
% y_B_new = y_B;
% c = linspace(1,10,length(x_B_new));
% scatter(x_B_new, y_B_new, [], c);
% ylim([-0.2 0.3])
% xlim([-0.001 1.001])

%% 1.2.1 C_l convergence
j = 1;
for i=4:1:100
    [~,~,~,~,x_u,y_u,x_L,y_L] = plotAirfoil(NACA,i);
    x_B = [flip(x_L(2:end)),x_u(1:end)];
    y_B = [flip(y_L(2:end)),y_u(1:end)];
    c_l(i) = Vortex_Panel(x_B,y_B,alpha1);
    x_loc(i) = i;
    C_l_goal(i) = 100*abs(c_l(i)-(C_l_true))/C_l_true;
end
k = find(C_l_goal(5:end)<1,1)+5;

figure();
hold on; grid on; grid minor;
plot(x_loc, c_l,'LineWidth',2);
title("NACA 0006: Convergence of c_l");
xlabel("Number of Total Panels on Airfoil");
ylabel("Sectional Coefficient of Lift, c_l");


%% 1.2.1 Angle of attack
i=1;
for a=-8:1:14
    [a6,cl6,~,~,x_u6,y_u6,x_L6,y_L6] = plotAirfoil('0006',100);
    x_B6 = [flip(x_L6(2:end)),x_u6(1:end)];
    y_B6 = [flip(y_L6(2:end)),y_u6(1:end)];
    c_l6a(i) = Vortex_Panel(x_B6,y_B6,a);
    [a12,cl12,~,~,x_u12,y_u12,x_L12,y_L12] = plotAirfoil('0012',100);
    x_B12 = [flip(x_L12(2:end)),x_u12(1:end)];
    y_B12 = [flip(y_L12(2:end)),y_u12(1:end)];
    c_l12a(i) = Vortex_Panel(x_B12,y_B12,a);
    [a18,cl18,~,~,x_u18,y_u18,x_L18,y_L18] = plotAirfoil('0018',100);
    x_B18 = [flip(x_L18(2:end)),x_u18(1:end)];
    y_B18 = [flip(y_L18(2:end)),y_u18(1:end)];
    c_l18a(i) = Vortex_Panel(x_B18,y_B18,a);
    i = i + 1;
end

figure();
hold on; grid on; grid minor;
plot(-8:1:14, c_l6a,'b','LineWidth',1);
plot(-8:1:14, c_l12a,'r','LineWidth',1);
plot(-8:1:14, c_l18a,'g','LineWidth',1);
plot(Exp006Data(:,1), Exp006Data(:,2),'b--','LineWidth',1);
plot(Exp012Data(:,1), Exp012Data(:,2),'r--','LineWidth',1);
plot(a6, cl6,'b.-','LineWidth',1);
plot(a12, cl12,'r.-','LineWidth',1);
plot(a18, cl18,'g.-','LineWidth',1);
title("NACA Airfoil c_l");
xlabel("Angle of Attack [deg]");
ylabel("Sectional Coefficient of Lift, c_l");
legend("NACA 0006 Vortex Panel","NACA 0012 Vortex Panel","NACA 0018 Vortex Panel","NACA 0006 Experimental", "NACA 0012 Experimental","NACA 0006 TAT", "NACA 0012 TAT", "NACA 0018 TAT","Location","southeast")
xlim([-8, 10]);
