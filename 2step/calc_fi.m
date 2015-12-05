function [ fi ] = calc_fi( z, b, entries)
    
    fi=-z;
    fi(entries)= sum(z(1:entries-1))-1;
    
end

