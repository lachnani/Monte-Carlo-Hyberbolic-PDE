%Explicit Method
n = 4;
h = 2/n;
m = 30;
k = 3/m;
%Define rho
rho = 3*(k/h)^2;
%Initial conditions
xvec = linspace(0,2,n+1);
yvec = linspace(0,2,n+1);
fr = zeros(n+1,n+1);
disp('______________________________________________________________________________________________________')
disp('   t      (.5,.5)   (1,.5)    (1.5,.5)   (.5,1)    (1,1)    (1.5,1)   (.5,1.5)   (1,1.5)   (1.5,1.5)')
disp('______________________________________________________________________________________________________')
for i = 2:n
    for j = 2:n
        fr(i,j) = analyticmembrane(xvec(i),yvec(j),0);%at t=0, this is only the function for initial conditions
    end
end
fprintf('%7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f    %7.4f\n',0,fr(2,2),fr(3,2),fr(4,2),fr(2,3),fr(3,3),fr(4,3),fr(2,4),fr(3,4),fr(4,4));
uc = fr;
ui = uc;
for i = 2:(n-1)
    for j = 2:(n-1)
        uc(i,j) = ui(i,j) + .5*rho*(ui(i+1,j)+ui(i-1,j)+ui(i,j+1)+ui(i,j-1)-4*ui(i,j));
    end
end
fprintf('%7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f    %7.4f\n',k,uc(2,2),uc(3,2),uc(4,2),uc(2,3),uc(3,3),uc(4,3),uc(2,4),uc(3,4),uc(4,4));
ui = uc;
for z = 2
    for i = 2:(n-1)
        for j = 2:(n-1)
            fr(i,j) = 2*uc(i,j) - ui(i,j) + rho*(uc(i+1,j)+uc(i-1,j)+uc(i,j+1)+uc(i,j-1)-4*uc(i,j));
        end
    end
    ui = uc;
    uc = fr;
    fprintf('%7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f   %7.4f    %7.4f\n',k*z,fr(2,2),fr(3,2),fr(4,2),fr(2,3),fr(3,3),fr(4,3),fr(2,4),fr(3,4),fr(4,4));
end  
[xgrid, ygrid] = meshgrid(xvec,yvec);
surf(xgrid,ygrid,fr);

