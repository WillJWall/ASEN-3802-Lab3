close all; clear; clc;
NACA = '4415'; % INPUT NUMBER ONLY

m = str2num(NACA(1))/100;
p = str2num(NACA(2))/10;
t = str2num(NACA(3))/10 + str2num(NACA(4))/100;

c = 1;
x = 0:0.01:c;

% equations

y_c1 = (2*p-(x/c)).*m.*x/(p^2);
y_c2 = m.*(c-x).*(1+(x/c)-(2*p)) / ((1-p)^2);

y_t = @(x) (t*c/0.2)*((0.2969*sqrt(x/c))-(0.126*(x/c))-(0.3516*((x/c).^2))+0.2843*((x/c).^3))-(0.1036*((x/c).^4));
y_t1 = y_t(x);

%y_c1 = @(x) m

dy_c1dx = @(x) 2*m*(c*p-x)/c/(p^2);
dy_c2dx = @(x) (2*m*(c*p-x)) / (c*((1-p)^2));


zeta1 = @(x) atan(dy_c1dx(x));
zeta2 = @(x) atan(dy_c2dx(x));


x_u = @(x) x - y_t(x)*sin(zeta1);

