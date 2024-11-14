close all; clear; clc;
NACA = '4415'; % INPUT NUMBER ONLY

plotAirfoil('4415');
plotAirfoil('0012');
plotAirfoil('0021');
plotAirfoil('2421');


function [] = plotAirfoil(NACA)
    % Clustering
    angles = linspace(0,pi,101);
    x = flip((cos(angles)+1)/2);
    
    % NACA Information
    m = str2num(NACA(1))/100; % Max camber
    p = str2num(NACA(2))/10; % Location of max camber
    t = str2num(NACA(3))/10 + str2num(NACA(4))/100; % Max thickness
    c = 1; % Chord Length
    
    % Half thickness
    y_t = (t*c/0.2)*((0.2969*sqrt(x/c)) - (0.126*(x/c)) - (0.3516*((x/c).^2)) + (0.2843*((x/c).^3)) - (0.1036*((x/c).^4)) );
    
    % Mean Camber Line
    if (p~=0) % For cambered airfoil
        y_c1 = (2*p-(x/c)).*m.*x/(p^2);
        y_c2 = m.*(c-x).*(1+(x/c)-(2*p)) / ((1-p)^2);
    
        dy_c1dx = 2*m*(c*p-x)/c/(p^2);
        dy_c2dx = (2*m*(c*p-x)) / (c*((1-p)^2));
    else % For symmetric airfoil
        y_c1 = 0*x;
        y_c2 = 0*x;
    
        dy_c1dx = 0*x;
        dy_c2dx = 0*x;
    end
    
    % Local angle
    zeta1 = atan(dy_c1dx);
    zeta2 = atan(dy_c2dx);
    
    % Lower Coordinates
    x_ua =  x - (y_t.*sin(zeta1));
    x_La =  x + (y_t.*sin(zeta1));
    y_ua =  y_c1 + (y_t.*cos(zeta1));
    y_La =  y_c1 - (y_t.*cos(zeta1));
    
    % Upper Coordinates
    x_ub =  x - (y_t.*sin(zeta2));
    x_Lb =  x + (y_t.*sin(zeta2));
    y_ub =  y_c2 + (y_t.*cos(zeta2));
    y_Lb =  y_c2 - (y_t.*cos(zeta2));
    
    midlimit = find(x>(p*c),1);
    limit = find(x==c,1);
    
    % Final Coordinates
    x_u = [x_ua(1,1:midlimit),x_ub(1,midlimit+1:limit)];
    y_u = [y_ua(1,1:midlimit),y_ub(1,midlimit+1:limit)];
    x_L = [x_La(1,1:midlimit),x_Lb(1,midlimit+1:limit)];
    y_L = [y_La(1,1:midlimit),y_Lb(1,midlimit+1:limit)];
    y_camber = [y_c1(1,1:midlimit),y_c2(1,midlimit+1:limit)];

    % Plotting
    figure('Position', [40 60 700 400]); hold on; grid on;
    title("Airfoil: NACA " + NACA)
    xlabel("Distance along Chord");
    ylabel("Thickness");
    plot(x_u,y_u,'r.');
    plot(x_L,y_L,'r.');
    plot(x, y_camber,'r');
    ylim([-0.2 0.3])
    xlim([-0.001 1.001])
end
