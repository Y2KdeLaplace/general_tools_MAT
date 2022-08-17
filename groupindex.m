function index = groupindex(total,points)
%GROUPINDEX This function is to deal with the situtation when need an index
%contain many numbers, such as [1:5]==[3,1] to get [1,0,1,0,0]
%index = groupindex(total,point)
%   total --- to get position index from this matrix
%   point --- elements should contain the elements in TOTAL
%   index --- POINT elements index (LOGICAL value)
points=points(:);
index = zeros(size(total));
for i = 1:length(points)
    tmp_matrix = total==points(i);
    index = index+tmp_matrix;
end
index = logical(index);
end
