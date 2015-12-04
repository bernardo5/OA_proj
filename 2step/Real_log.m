function [ l ] = Real_log( fi )
%returns log preventing it to be imaginary

if fi>0
    l=log(fi);
else
   l=-Inf;
end
end

