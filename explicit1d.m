%Hyperbolic PDE 
%Set up initial conditions
T = 40000;
g = 980;
w = 1/80;
c = sqrt(T*g/w);
n = 7; %Number of nodes in x
h = 80/(n+1);
m = 50; %Number of nodes in t
k = 5/m;
%Set up Numerical Analysis
rho = (c*k/h)^2;%rho must be less than 1
%Set K matrix
K = zeros(n,n);
u = zeros(n,1);
for j = 1:n
    K(j,j)=2;
end
for j = 1:(n-1)
    K(j+1,j)=-1;
    K(j,j+1)=-1;
end
%Set up b vector
b = zeros(n,1);
b(1) = -1;
b(n) = -1;
h = linspace(0,80,n+1);
w = zeros(n,1);%2 lines previous
for i =1:n
    w(i) = .5*(oddf(h(i+1))+oddf(h(i+1)));
end
fprintf('%7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f\n',0,0.0000,w(1),w(2),w(3),w(4),w(5),w(6),0.0000);
x = zeros(n,1);%Previous line
t = 0;
for i =1:n
    x(i) = .5*(oddf(h(i+1)-(c*k))+oddf(h(i+1)+(c*k)));
end
fprintf('%7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f\n',k,0.0000,x(1),x(2),x(3),x(4),x(5),x(6),0.0000);
I = eye(n,n);
for j = 2:m
    tempsol = 2*(((4/rho).*I)-K)*x - 4.*b;
    sol = Naive_Gauss(n,((4/rho).*I)+K,tempsol);
    sol = sol - w;
    w = x;
    x = sol;
    fprintf('%7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f\n',j*k,0.0000,x(1),x(2),x(3),x(4),x(5),x(6),0.0000);
end




