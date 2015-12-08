function [ phi ] = phi(z,n)
phi=0;
 for i=1:n-1
        if(z(i)>=0)
        phi=phi+log(z(i));
        else
            phi=phi-inf;
        end
 end
     phi=-phi-log(1-sum(z));
end

%     phi=0;
%     for i=1:49
%     phi=phi+log(z(i));
%     end
%     phi=-phi-log(1-sum(z));
%     if(isreal(phi)==0)
%     phi=inf;
%     end