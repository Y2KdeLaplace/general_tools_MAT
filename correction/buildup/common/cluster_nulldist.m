function perm = cluster_nulldist(perm)
%CLUSTER_NULLDIST
%
% perm = cluster_nulldist(perm)
% make sure input perm had:
% perm.h: nperm*para1(*para2)
% perm.dist: nperm*para1(*para2)
% perm.cluster_calc_stat_method
%
% we will get perm.clusterstat & perm.clustersize (nperm*1)
% the cluster-level null distribution
%
% Written by HU Yiheng
% Modified by LI Siyi (2022.11.22)
% Update codes by HU Yiheng (2022.12.6)
% 
h = perm.h;
dist = perm.dist;
method = perm.cluster_calc_stat_method;

null_stat_dist = nan(perm.iterperm,1);
null_size_dist = nan(perm.iterperm,1);
parfor i = 1:perm.iterperm
    
    if sum(h(i,:,:))==0
        continue
    end
    
    [clustersize,clusterstat,~] = cluster_stats(size_makeup(dist(i,:,:)),...
        size_makeup(h(i,:,:)), method);
    
    [null_size_dist(i), ~] = max(clustersize);
    
    % to average stats with the maxest multiple clusters
    null_stat_dist(i,1) = mean(clusterstat(clustersize==null_size_dist(i)));
    
    
end
perm.clusterstat = null_stat_dist(~isnan(null_stat_dist));
perm.clustersize = null_size_dist(~isnan(null_size_dist));



