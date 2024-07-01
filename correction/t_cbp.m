function [cbp_h, cr, perm] = t_cbp(alldata, m, sides, feature_alpha, cluster_alpha, ...
    whichstat, method, iteration)
% t-test cluster based correction
%
% [cbp_h,cr,perm] = t_cbp(alldata, m, sides, feature_alpha, cluster_alpha, whichstat, method, iteration)
% alldata: subj*feature1(*feature2); e.g. subj*tp or subj*tp*freq
% m: mean value to be compared in each feature statistics
% sides: 'right', 'left', 'both'
% feature_alpha: each feature alpha
% cluster_alpha: alpha for cluster correction, (0.05 easily escape correction, 0.01 preferred)
% whichstat: statistics of clusters; options ('stat', 'size')
% method: the method to calculate the statistics; options ('sum', 'mean')
% iteration: the times of iteration, usually 10000
%
% Written by Yiheng Hu
rng('shuffle','twister')

%% true data p-map stat
cr = init_correction(size_makeup(mean(alldata,1)), whichstat, method, iteration);
[cr.h, cr.p, cr.stat] = tcheck(alldata, m, sides, feature_alpha);
[cr.clustersize, cr.clusterstat, cr.labels] = cluster_stats(cr.stat, cr.h, cr.cluster_calc_stat_method);

%% permutation p-map stat
perm = init_correction([], whichstat, method, iteration);
perm = tperm_feature(perm, alldata, m, sides, feature_alpha); %the slowest step

%% cluster-based correction
perm = cluster_nulldist2(perm);
cbp_h = cluster_based_correction(cr, perm, sides, cluster_alpha);



