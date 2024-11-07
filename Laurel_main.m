close all; clear; clc;
NACA = '4415'; % INPUT NUMBER ONLY

m = str2num(NACA(1))/100;
p = str2num(NACA(2))/10;
t = str2num(NACA(3))/10 + str2num(NACA(4))/100;

c = 1;
% Clustering
angles = linspace(0,pi,101);
x1 = cos(angles);
%scatter(x_pos, ones(1,50));

x = 0:0.01:c;

% equations

y_t = (t*c/0.2)*( (0.2969*sqrt(x/c)) - (0.126*(x/c)) - (0.3516*((x/c).^2)) + (0.2843*((x/c).^3)) - (0.1036*((x/c).^4)) );


%y_c1 = @(x) m

y_c1 = (2*p-(x/c)).*m.*x/(p^2);
y_c2 = m.*(c-x).*(1+(x/c)-(2*p)) / ((1-p)^2);

dy_c1dx = 2*m*(c*p-x)/c/(p^2);
dy_c2dx = (2*m*(c*p-x)) / (c*((1-p)^2));


zeta1 = atan(dy_c1dx);
zeta2 = atan(dy_c2dx);


x_u1 =  x - (y_t.*sin(zeta1));
x_L1 =  x + (y_t.*sin(zeta1));
y_u1 =  y_c1 + (y_t.*cos(zeta1));
y_L1 =  y_c1 - (y_t.*cos(zeta1));

x_u2 =  x - (y_t.*sin(zeta2));
x_L2 =  x + (y_t.*sin(zeta2));
y_u2 =  y_c1 + (y_t.*cos(zeta2));
y_L2 =  y_c1 - (y_t.*cos(zeta2));

midlimit = find(x==(p*c),1);
limit = find(x==c,1);

x_u = [x_u1(1,1:midlimit),x_u2(1,midlimit+1:limit)];
y_u = [y_u1(1,1:midlimit),y_u2(1,midlimit+1:limit)];
x_L = [x_L1(1,1:midlimit),x_L2(1,midlimit+1:limit)];
y_L = [y_L1(1,1:midlimit),y_L2(1,midlimit+1:limit)];

hold on;
plot(x_u,y_u);
plot(x_L,y_L);
ylim([-0.2 0.3])



