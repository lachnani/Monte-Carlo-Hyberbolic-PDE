function [fr] = analyticmembrane(x,y,t)
%ANALYTICMEMBRANE Analytic solution to memebrane problem
%   Fourier Series
format long
if t == 0
    fr = x*(2-x)*(2-y)*y;
else
    fr = 0;
    for n =2:2:10
        B = 32/((pi^3)*(n^3));
        for m=2:2:10
            B = B*(32/((pi^3)*(m^3)));
            lam = pi*sqrt(3)*sqrt(((m^2)/4) + ((n^2)/4));
            fr = fr + B*cos(lam*t)*sin(m*pi*x/2)*sin(n*pi*y/2);
        end
    end
end
        
        

end

