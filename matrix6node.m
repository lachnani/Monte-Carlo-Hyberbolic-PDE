T = 40;
g = .980;
w = 1/80;
c = sqrt(T*g/w);
n = 6+2;
h = 80/(n-1);
k = .1;
rho = (c*k/h)^2;%rho must be less than 1
%Setup Matrix
A = zeros(8,8);
for j = 1:n
    A(j,j)=2*(1-rho);
end
for j = 1:(n-1)
    A(j+1,j)=rho;
    A(j,j+1)=rho;
end
%Setup iteration
t = 0;
h = linspace(0,80,7);
x = zeros(1,n);%Previous Line
q = zeros(1,n);%Previous Previous Line
for i = 2:(n-1)
    x(i) = .5*(oddf(h(i)-(c*t))+oddf(h(i)+(c*t)));
end
t = .1;
for i = 2:(n-1)
    q(i) = x(i);
    x(i) = .5*(oddf(h(i)-(c*t))+oddf(h(i)+(c*t)));
end
disp('_________________________________________________________________________________________________________________________________')
disp('     t            0           10           20           30           40           50           60           70           80 ')
disp('_________________________________________________________________________________________________________________________________')
fprintf(' %7.4f      %7.4f      %7.4f      %7.4f      %7.4f      %7.4f      %7.4f      %7.4f       %7.4f\n',0,q(1),q(2),q(3),q(4),q(5),q(6),q(7),q(8));
fprintf(' %7.4f      %7.4f      %7.4f      %7.4f      %7.4f      %7.4f      %7.4f      %7.4f       %7.4f\n',.1,x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8));
ts = t;
u = zeros(1,n);
for k = 2:100
    t = k*ts;
    xtemp = permute(x,[2 1]);
    u = A*xtemp;
    for i = 2:(n-1)
         u(i) = u(i) - q(i);
    end
    q = x;
    x = permute(u,[2 1]);
    fprintf(' %7.4f      %7.4f      %7.4f      %7.4f      %7.4f      %7.4f      %7.4f      %7.4f       %7.4f\n',t,x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8));
end