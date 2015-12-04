function [ A ] = Armijo( t, miu, D, z, b, gama, cov, phi, alfa, c1, grad, d)

A=((t*(-miu'*(D*z+b)+gama*(D*z+b)'*cov*(D*z+b))+phi)+alfa*c1*grad'*d);

end

