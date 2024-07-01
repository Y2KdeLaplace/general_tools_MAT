function [cbp_h, cr, perm] = perm_cbp(alldata, m, sides, feature_alpha, cluster_alpha, ...
    whichstat, method, iteration)
% permutation cluster based correction
%
% cbp_h = perm_cbp(alldata, feature_alpha, whichstat, method, iteration, cluster_alpha)
% alldata: subj*feature1(*feature2); e.g. subj*tp or subj*tp*freq
% feature_alpha: each feature alpha
% whichstat: statistics of clusters; options ('stat', 'size')
% method: the method to calculate the statistics; options ('sum', 'mean')
% iteration: the times of iteration, usually 10000
% cluster_alpha: alpha for cluster correction, (0.05 easily escape correction, 0.01 preferred)
% 
% one-tail above 0 comparison
rng('shuffle','twister');
alldata = alldata - m; % for signflip

%% permutation p-map stat
perm = init_correction([], whichstat, method, iteration);
perm = signflip(perm,alldata,iteration);
perm = perm_proportion(perm,sides); % the slowest step
perm.h = perm.p<feature_alpha;

%% true data p-map stat
cr = init_correction(size_makeup(mean(alldata,1)), whichstat, method, iteration);
cr = dist_proportion(cr,perm,sides);
cr.h = cr.p<feature_alpha;
[cr.clustersize, cr.clusterstat, cr.labels] = cluster_stats(cr.stat, cr.h, cr.cluster_calc_stat_method);

%% cluster-based correction
perm = cluster_nulldist2(perm);
cbp_h = cluster_based_correction(cr, perm, sides, cluster_alpha);


