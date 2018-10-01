%Analytic Solution
c = sqrt(3);
xvec = linspace(0,2,100);
yvec = linspace(0,2,100);
fr = zeros(100,100);
for t = 0:.5:10
    for i = 1:100
        for j = 1:100
            fr(i,j) = analyticmembrane(xvec(i),yvec(j),t);
        end
    end
end
%Plot mesh
[xgrid, ygrid] = meshgrid(xvec,yvec);
surf(xgrid,ygrid,fr);

            
        