%Hyperbolic PDE
%Implicit method
%Set up initial conditions
T = 40;
g = .980;
w = 1/80;
c = sqrt(T*g/w);
n = 1000; %Number of nodes in x
h = 80/(n+1);
m = 50; %Number of nodes in t
k = 5/m;
%Set up Numerical Analysis
rho = (c*k/h)^2;
e = zeros(n,1);
d = zeros(n,1);
a = zeros(n,1);
u = zeros(n,1);
b = zeros(n,1);
%First two lines
h = linspace(0,80,(n+1));
x = zeros(n,1);
w = zeros(n,1);
for i =1:n
    w(i)=.5*(oddf(h(i+1))+oddf(h(i+1)));
    x(i)=.5*(oddf(h(i+1)-(c*k))+oddf(h(i+1)+(c*k)));
end
fprintf('%7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f\n',0,0,w(1),w(2),w(3),w(4),w(5),w(6),0.0000);
fprintf('%7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f\n',k,0,x(1),x(2),x(3),x(4),x(5),x(6),0.0000);
for j = 2:m
    for i = 1:n
%         w(i)=.5*(oddf(h(i+1))+oddf(h(i+1)));
%         x(i)=.5*(oddf(h(i+1)-(c*j))+oddf(h(i+1)+(c*j)));
        d(i) = 2*(1-(2/rho));
        if i == 1
            b(i) = 2*(x(i+1)-((2-(4/rho))*x(i))) + w(i+1)-((2-(4/rho))*w(i));
        elseif i == n
            b(i) = 2*(x(i-1)-((2-(4/rho))*x(i))) + w(i-1)-((2-(4/rho))*w(i));
        else
            b(i) = 2*(x(i+1)-((2-(4/rho))*x(i)+x(i-1))) + w(i+1)-((2-(4/rho))*w(i))+w(i-1);
        end
    end
    for i = 1:(n-1)
        a(i) = -1;
        e(i) = -1;
    end
    %Tridiagonal System
    for i = 2:n
        xmult = a(i-1)/d(i-1);
        d(i) = d(i) - xmult*e(i-1);
        b(i) = b(i) - xmult*b(i-1);
    end
    u(n) = b(n)/d(n);
    for i = (n-1):-1:1
        u(i) = (b(i)-e(i)*u(i+1))/d(i);
    end
    w = x;
    x = u;
    fprintf('%7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f\n',j*k,0,u(1),u(2),u(3),u(4),u(5),u(6),0.0000);
end