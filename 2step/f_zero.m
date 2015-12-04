function [ f0 ] = f_zero ( miu, D, z, b, gama, cov )
%returns function f0
f0=(-miu'*(D*z+b)+gama*(D*z+b)'*cov*(D*z+b));
end

