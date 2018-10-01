%Hyperbolic PDE 
%Set up initial conditions
T = 40000;
g = 980;
w = 1/80;
c = sqrt(T*g/w);
c = 56;
n = 7; %Number of nodes in x
h = 80/n;
m = 50; %Number of nodes in t
k = 5/m;
%Set up Numerical Analysis
rho = (c*k/h)^2;
u = zeros(1,n+1);%line being calculates
v = zeros(1,n+1);%previous line
w = zeros(1,n+1);%previous previous line
%Boundary conditions
u(1) = 0;
v(1) = 0;
w(1) = 0;
u(n+1) = 0;
v(n+1) = 0;
w(n+1) = 0;
for i = 2:n
    x = (i-1)*h;
    w(i) = oddf(x);%2 lines previous
    v(i) = .5*rho*(oddf(x-h)+oddf(x+h))+(1-rho)*oddf(x);%previous line
end
v(n) = .5*rho*(w(i-2)+w(i))+(1-rho)*w(i-1);
for j = 2:m
    
end
disp('________________________________________________________________________________________')
disp('    t        0       11.43     22.86     34.29     45.71     57.14     68.57     80  ')
disp('________________________________________________________________________________________')
for j = 2:30
    for i = 2:n
        u(i) = rho*(v(i+1)+v(i-1))+2*(1-rho)*v(i)-w(i);
    end
    fprintf('%7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f\n',j*k,u(1),u(2),u(3),u(4),u(5),u(6),u(7),u(8));
    for i = 1:n
        w(i) = v(i);
        v(i) = u(i);
    end
end
