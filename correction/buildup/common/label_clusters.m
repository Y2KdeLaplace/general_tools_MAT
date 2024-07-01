function newh = label_clusters(h,spatialind)
%LABEL_CLUSTERS label cluster according to spatial indices
% newh = label_clusters(h,spatialind)
% h: a n*1 vector or m*n matrix
% spatialind: a cell array with the same size as H. Each cell indicate the
% neighbor features of the corresponding feature.
%
% Written by Yiheng Hu (2024.2.26)
[a,b] = size(h);
h = h(:);
spatialind = spatialind(:);
sign_ind = find(h);

newh = zeros(size(h));
chk_mark_list = zeros(size(newh));
label_num = 1;
for i = 1:length(sign_ind)
    a_sign_ind = sign_ind(i);
    if ~newh(a_sign_ind)
        newh(a_sign_ind) = label_num;
        tmp = a_sign_ind;
        while sum(logical(newh)-chk_mark_list)~=0
            a_sign_ind = tmp(1);
            ind = spatialind{a_sign_ind};
            ind = ind(:);
            marked_ind = ind(h(ind)&~newh(ind));
            newh(marked_ind) = label_num;

            chk_mark_list(a_sign_ind) = 1;
            tmp = find(logical(newh)-chk_mark_list);
        end
        label_num = label_num+1;
    end
end
newh = reshape(newh,[a,b]);

