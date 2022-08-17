function jud = iscontinue(x)
%ISCONTINUE
%   to judge if the unique elements in a vector or a matrix are continuous 
%   x --- a set of vector
%   written by Yiheng Hu(2022.8.17)
check = unique(x);
tmp = diff(check);
jud = all(ones(size(tmp))==tmp);
end

