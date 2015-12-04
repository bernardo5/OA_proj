function [ z ] = init_z( number_of_entries )
for i=1:number_of_entries-1
     z(i)=1/number_of_entries;
end
z=z';
end

