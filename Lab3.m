y_t = @(t,c,x) (t*c/0.2)((0.2969*sqrt(x/c))-(0.126*(x/c))-(0.3516*((x/c)^2))+0.2843*((x/c)^3))-(0.1036*((x/c)^4));

dy_c1-dx = @(x) 2*m*(c*p-x)/c/(p^2);
dy_c2-dx = @(x) (2*m*(c*p-x)) / (c*((1-p)^2));
