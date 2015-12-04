function [ fi ] = get_fi( z, entries )
fi=-z;
fi(entries)=sum(fi(1:entries-1))-1;
end

