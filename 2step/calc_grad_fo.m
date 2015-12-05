function [ grad_fo ] = calc_grad_fo( miu, gama, cov, z, D, b )

    grad_fo=(-miu'*D+2*gama*(D*z+b)'*cov*D);

end

