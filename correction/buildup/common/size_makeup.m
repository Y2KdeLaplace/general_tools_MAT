function d = size_makeup(d)
% d = size_makeup(d)
% a limited version of squeeze function
% if matrix m*1*n input, m*n output
% if vector m*1 or 1*m input, m*1 ouput
% Written by Yiheng Hu(2022.12.6)
if isvector(d)
    d = d(:);
else
    d = squeeze(d);
end
end

