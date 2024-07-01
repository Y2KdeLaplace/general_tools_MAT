function [clustersize,clusterstat,labels] = cluster_stats(statmap,hmap,method,fn)
%CLUSTER_STATS 
% summary of clusters: stat, size
% [clustersize,clusterstat] = cluster_stats(statmap,hmap,method)
% method: 'mean', 'sum' or others
% using 'hmap' to find clusters and label these clusters
% manipulate clusters in 'statmap' with 'method'

if nargin < 4
    labels = bwlabel(hmap);
else
    if isa(fn,'function_handle')
        labels = fn(hmap);
    else
        labels = bwlabel(hmap,fn);
    end
end
ncluster = max(labels,[],'all');
clusterstat = nan(1,ncluster);
clustersize = nan(1,ncluster);

f=str2func(method);
for i = 1:max(labels(:))
    clustersize(i) = sum(labels==i,'all');
    clusterstat(i) = f(statmap(labels==i));
end


