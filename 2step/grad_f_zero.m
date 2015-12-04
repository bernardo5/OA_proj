function [ grad_fo ] = grad_f_zero( t, miu, D, gama, b, z, cov )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
grad_fo=t*(-miu'*D+gama*(D*z+b)'*2*cov*D);

end

