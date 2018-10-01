function [z] = membranef(x,y)
%MEMBRANEF Initial condition for membrance problem.
z = x*(2-x)*(2-y)*y;

end

