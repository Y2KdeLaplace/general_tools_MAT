function labels = clusterize(cbp_h,thr)
%CLUSTERIZE 
% labels = clusterize(cbp_h,thr)
% cbp_h - array or matrix with 1 and 0
% thr - feature number of threshold
[~,labels] = bwboundaries(cbp_h);
for i = 1:max(labels)
    if sum(labels==i) < thr
        labels(labels==i) = 0;
    end
end

