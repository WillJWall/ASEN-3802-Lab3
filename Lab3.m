close all; clear; clc;
NACA = '0021';
alpha1 = 10; % AOA [deg]
%Exp006Data = load("Dataset Reynolds 9E8.csv"); %(section aoa [deg], section C_L)

%[x_u,y_u,x_L,y_L] = plotAirfoil(NACA,20);

[x_u,y_u,x_L,y_L] = plotAirfoil(NACA,2000);
x_B = [flip(x_L(2:end)),x_u(1:end)];
y_B = [flip(y_L(2:end)),y_u(1:end)];
C_l_true = Vortex_Panel(x_B,y_B,alpha1);

figure(); hold on;
x_B_new = x_B;
y_B_new = y_B;
c = linspace(1,10,length(x_B_new));
scatter(x_B_new, y_B_new, [], c);
ylim([-0.2 0.3])
xlim([-0.001 1.001])


j = 1;
for i=4:1:200
    [x_u,y_u,x_L,y_L] = plotAirfoil(NACA,i);
    x_B = [flip(x_L(2:end)),x_u(1:end)];
    y_B = [flip(y_L(2:end)),y_u(1:end)];
    c_l(i) = Vortex_Panel(x_B,y_B,alpha1);
    x_loc(i) = i;
    C_l_goal(i) = 100*abs(c_l(i)-(C_l_true))/C_l_true;
end
k = find(C_l_goal(3:end)<1,1);

figure();
hold on; grid on;
plot(x_loc, c_l);
