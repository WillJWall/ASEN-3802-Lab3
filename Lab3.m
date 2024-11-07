NACA = '4415'; % INPUT NUMBER ONLY

m = str2num(NACA(1))/100;
p = str2num(NACA(2))/10;
t = str2num(NACA(3))/10 + str2num(NACA(4))/100;

y_t = (t*c/0.2)*((0.2969*sqrt(x/c))-(0.126*(x/c))-(0.3516*((x/c)^2))+0.2843*((x/c)^3))-(0.1036*((x/c)^4));

%y_c1 = @(x) m

dy_c1dx = 2*m*(c*p-x)/c/(p^2);
dy_c2dx = (2*m*(c*p-x)) / (c*((1-p)^2));


zeta1 = atan(dy_c1dx);
zeta2 = atan(dy_c2dx);
