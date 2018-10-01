%Explicit Method
n = 50;
h = 2/n;
m = 800;
k = 10/m;
%Define rho
rho = 3*(k/h)^2;
%Initial conditions
xvec = linspace(0,2,n);
yvec = linspace(0,2,n);
fr = zeros(n,n);
for i = 2:(n-1)
    for j = 2:(n-1)
        fr(i,j) = analyticmembrane(xvec(i),yvec(j),0);%at t=0, this is only the function for initial conditions
    end
end
uc = fr;
ui = uc;
for i = 2:(n-1)
    for j = 2:(n-1)
        uc(i,j) = ui(i,j) + .5*rho*(ui(i+1,j)+ui(i-1,j)+ui(i,j+1)+ui(i,j-1)-4*ui(i,j));
    end
end
ui = uc;
for z = 2:m
    for i = 2:(n-1)
        for j = 2:(n-1)
            fr(i,j) = 2*uc(i,j) - ui(i,j) + rho*(uc(i+1,j)+uc(i-1,j)+uc(i,j+1)+uc(i,j-1)-4*uc(i,j));
        end
    end
    ui = uc;
    uc = fr;
end  
%Plot mesh
[xgrid, ygrid] = meshgrid(xvec,yvec);
set(gcf,'renderer','zbuffer');
surf(xgrid,ygrid,fr);
