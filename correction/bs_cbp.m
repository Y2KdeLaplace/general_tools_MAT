function [cbp_h, cr, perm] = bs_cbp(alldata, m, feature_alpha, cluster_alpha, ...
    whichstat, method, iteration, nbs)
% Cluster-based correction using bootstrapping procedure
% one-tail above 'm' comparison
% methods: 'Sum'/'Mean'
% nbs: number of bootstrap
% clusterCmp_type: corrected criterion ('stat'; 'size' with 2 )
%
% Output: a logical matrix with 1 represent datapoint surviving the correction

% Writtern by HU YIheng
% Modified by LSY (2022 Nov 22)
% Update (2022.12.6)
rng('shuffle','twister')

%% true data p-map stat
cr = init_correction(size_makeup(mean(alldata,1)), whichstat, method, iteration);
cr = bootstrapCheck(cr,alldata,nbs,m,feature_alpha);
[cr.clustersize, cr.clusterstat, cr.labels] = cluster_stats(cr.stat, cr.h, cr.cluster_calc_stat_method);

%% permutation p-map stat
perm = init_correction([], whichstat, method, iteration);
perm = bsperm(alldata, perm, m, nbs, feature_alpha); %the slowest step

%% cluster-based correction
perm = cluster_nulldist(perm);
cbp_h = cluster_based_correction(cr, perm, sides, cluster_alpha);

