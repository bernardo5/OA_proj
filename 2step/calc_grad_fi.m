function [ grad_fi ] = calc_grad_fi( fi, entries )

    for i=1:entries-1
        grad_fi{i}=zeros(entries-1,1);
        grad_fi{i}(i)=-1;
    end
    grad_fi{entries}=ones(entries-1,1);

end

