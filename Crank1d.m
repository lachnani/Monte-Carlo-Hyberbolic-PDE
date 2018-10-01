%Hyperbolic PDE 
%Set up initial conditions
T = 40;
g = .980;
w = 1/80;
c = 56;
n = 80; %Number of nodes in x
h = 80/n;
m = 500; %Number of nodes in t
k = 5/m;
%Set up Numerical Analysis
rho = (c*k/h)^2;%rho must be less than 1
u = zeros(1,n+1);%line being calculated
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
    %w(i)
    %f(x)
    w(i) = oddf(x);
    %v(i)
    v(i) = .5*rho*(oddf(x-h)+oddf(x+h))+(1-rho)*oddf(x);
end
b = zeros(n+1,1);
I = zeros(n+1,n+1);
disp('______________________________________________________________________________________________________')
disp('   t         0         10        20        30        40        50        60        70         80')
disp('______________________________________________________________________________________________________')
for j = 2:m
    for i = 2:n
        u(i) = rho*(v(i+1)+v(i-1))+2*(1-rho)*v(i)-w(i);
    end
    for i =2:n
        b(i) = 2*u(i)+.5*rho*v(i-1)+.5*rho*v(i+1)-rho*v(i);
    end
    for i = 1:(n+1)
        I(i,i) = 1+rho;
    end
    for i = 1:n
        I(i+1,i) = -.5*rho;
        I(i,i+1) = -.5*rho;
    end
    for i = 1:n
        w(i) = v(i);
        v(i) = u(i);
    end
    u = Naive_Gauss(n+1,I,b);
    fprintf('%7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f    %7.4f\n',j*k,u(1),u(11),u(21),u(31),u(41),u(51),u(61),u(71),u(81));
end

    
    

   
