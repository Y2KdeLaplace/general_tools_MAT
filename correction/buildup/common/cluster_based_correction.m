function cbp_h = cluster_based_correction(cr,perm,sides,cluster_alpha)
%CLUSTERS_BASED_CORRECTION do correction to clusters
% Updated by Yiheng Hu (2024.7.1)
%
% NOTE! only work in follow structure:
% cr.clusterstat: 1*nsample
% perm.clusterstat/perm.clustersize: nsample*1
% sides: 'left', 'right', 'both'
if ~strcmp(cr.cluster_which_stat,perm.cluster_which_stat)
    error('unsure to correct with size or stat')
elseif strcmp(cr.cluster_which_stat,'stat')
    clusters_truelist = cr.clusterstat;
    clusters_nulldist = perm.clusterstat;
elseif strcmp(cr.cluster_which_stat,'size')
    clusters_truelist = cr.clustersize;
    clusters_nulldist = perm.clustersize;
else
    error('unknown correction variable')
end

ptmp = mean(clusters_nulldist>clusters_truelist,1);
if strcmp(sides,'right')
    clusters_p = ptmp;
elseif strcmp(sides,'left')
    clusters_p = 1-ptmp;
elseif strcmp(sides,'both')
    clusters_p = 2*min(ptmp,1-ptmp);
end

rm_ind = find(clusters_p>=cluster_alpha);
cbp_h = cr.h;
for j = 1:length(rm_ind)
    cbp_h(cr.labels==rm_ind(j)) = 0;
end
cbp_h = logical(cbp_h);




