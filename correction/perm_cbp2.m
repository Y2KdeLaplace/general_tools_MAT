function [cbp_h,cr,perm] = perm_cbp2(truedat,permdat,sides,feature_alpha,cluster_alpha,whichstat,method)
% permutation cluster based correction
%
% [cbp_h,cr] = perm_cbp2(truedat,permdat,side,feature_alpha,whichstat,method,cluster_alpha)
% truedat: subj*feature1(*feature2); e.g. subj*tp or subj*tp*freq
% permdat: iteration*feature1(*feature2)
% sides: 'left','right','both'
% feature_alpha: each feature alpha
% cluster_alpha: alpha for cluster correction, (0.05 easily escape correction, 0.01 preferred)
% whichstat: statistics of clusters; options ('stat', 'size')
% method: the method to calculate the statistics; options ('sum', 'mean')
% 
% Written by Yiheng Hu (2024.6.30)
rng('shuffle','twister')

%% permutation p-map stat
perm = init_correction([], whichstat, method, size(permdat,1));
perm.dist = permdat;
perm = perm_proportion(perm,sides); % the slowest step
perm.h = perm.p<feature_alpha;

%% true data p-map stat
cr = init_correction(truedat, whichstat, method, size(permdat,1));
cr = dist_proportion(cr,perm,sides);
cr.h = cr.p<feature_alpha;
[cr.clustersize, cr.clusterstat, cr.labels] = cluster_stats(cr.stat, cr.h, cr.cluster_calc_stat_method);

%% cluster-based correction
perm = cluster_nulldist2(perm);
cbp_h = cluster_based_correction(cr, perm, sides, cluster_alpha);


