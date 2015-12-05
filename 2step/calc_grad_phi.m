function [ grad_phi ] = calc_grad_phi( fi, grad_fi, entries )

    grad_phi=0;
    for i=1:entries
    grad_phi=grad_phi+(1/-fi(i))*grad_fi{i};
    end

end

