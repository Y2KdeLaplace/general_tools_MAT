function perm = cluster_nulldist2(perm)
%CLUSTER_NULLDIST2 this version takes all permutated clusters and their
%statistics into cluster-level null distribution.
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
% Writtern by Yiheng Hu (2023.5.11)
%
h = perm.h;
dist = perm.dist;
method = perm.cluster_calc_stat_method;

null_stat_dist = cell(1,perm.iterperm);
null_size_dist = cell(1,perm.iterperm);
parfor i = 1:perm.iterperm
    
    if sum(h(i,:,:))==0
        continue
    end
    
    [null_size_dist{i},null_stat_dist{i},~] = cluster_stats(size_makeup(dist(i,:,:)),...
        size_makeup(h(i,:,:)), method);

end
perm.clusterstat = size_makeup(cell2mat(null_stat_dist));
perm.clustersize = size_makeup(cell2mat(null_size_dist));



