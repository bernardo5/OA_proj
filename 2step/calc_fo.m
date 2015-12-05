function [ fo ] = calc_fo( miu, gama, cov, z, D, b )

    fo=(-miu'*(D*z+b)+gama*(D*z+b)'*cov*(D*z+b));

end

