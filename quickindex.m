function out = quickindex(data,ind)
%QUICKINDEX Quickly index the data with index
if all(size(data)~=size(ind))
    error('Input arguments should be same size')
end
out = data(ind);
end

