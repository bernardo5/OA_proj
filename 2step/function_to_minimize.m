function [ f ] = function_to_minimize( t, miu, D, z, b, gama, cov, phi )
f=(t*(-miu'*(D*z+b)+gama*(D*z+b)'*cov*(D*z+b))+phi);
end

