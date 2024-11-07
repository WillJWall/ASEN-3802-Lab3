clc
clear
close all

% inputs
NACA = '4415'; % INPUT NUMBER ONLY

m = str2num(NACA(1))/100;
p = str2num(NACA(2))/10;
t = str2num(NACA(3))/10 + str2num(NACA(4))/100;

c = 1;
x = 0:0.01:c;

% equations
y_t = @(x) (t*c/0.2)*((0.2969*sqrt(x/c))-(0.126*(x/c))-(0.3516*((x/c).^2))+0.2843*((x/c).^3))-(0.1036*((x/c).^4));
y_t1 = y_t(x);

y_c1 = (2*p-(x/c)).*m.*x/(p^2);
y_c2 = m.*(c-x).*(1+(x/c)-(2*p)) / ((1-p)^2);

dy_c1dx = @(x) 2*m*(c*p-x)/c/(p^2); % 0<x<pc
dy_c1dx1 = dy_c1dx(x);

dy_c2dx = @(x) (2*m*(c*p-x)) / (c*((1-p)^2)); % pc<x<c
dy_c2dx2 = dy_c2dx(x);

% zeta definition
% zeta1 = @(x) atan(dy_c1dx(x));
zeta1 = atan(dy_c1dx1); % from 0<x<pc
% zeta2 = @(x) atan(dy_c2dx(x));
zeta2 = atan(dy_c2dx2); % from pc<x<c

% index to switch from zeta1 to zeta2:
p_switch = (length(x)-1) * p;

for p = 1:length(x)
    if p < p_switch
        % upper coordinates
        x_u(p) = x(p) - y_t(p) .* sin(zeta1(p));
        y_u(p) = y_c1(p) + y_t(p) .* cos(zeta1(p));
        
        % lower coordinates
        x_L(p) = x(p) + y_t(p) .* sin(zeta1(p));
        y_L(p) = y_c1(p) - y_t(p) .* cos(zeta1(p));
    else
        % upper coordinates
        x_u(p) = x(p) - y_t(p) .* sin(zeta2(p));
        y_u(p) = y_c2(p) + y_t(p) .* cos(zeta2(p));
        
        % lower coordinates
        x_L(p) = x(p) + y_t(p) .* sin(zeta2(p));
        y_L(p) = y_c2(p) - y_t(p) .* cos(zeta2(p));
    end
end

% plotting
figure()
hold on
plot(x_u,y_u,'k') % upper
plot(x_L,y_L,'b') % blue
hold off
