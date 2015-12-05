function [ phi ] = calc_phi( fi, entries )

    phi=0;
    for i=1:entries
        if(fi<=0) phi=phi+log(-fi(i));
        else phi=-inf;
        end
    end 
    phi=-phi;

end

