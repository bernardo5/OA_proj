function [ hess ] = calc_hess_phi( z, entries )

z1=1./z;

A=diag(z1.^2);

B=ones(entries-1,entries-1)* 1/((sum(z)-1)^2);

hess=A+B;

end

