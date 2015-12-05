function [ hess_fo ] = calc_hess_fo( gama, cov, D )

    hess_fo=gama*2*(D'*cov*D);

end

