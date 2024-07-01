function cr = init_correction(mu,whichstat,method,iteration,par)
%INIT_CORRECTION 
%   mu:                  mean value of data
%   whichstat:           'stat' or 'size'
%   method:              'sum' or 'mean'
%   iteration:           permutation times
%   par:                 1 - using parallel computation; 0 by default
% Created by Yiheng Hu(2022.6.16)
% Update by Yiheng Hu(2022.12.6)
if nargin<5; par=1; end
cr = struct('stat',mu);
cr.cluster_which_stat = whichstat;
cr.cluster_calc_stat_method = method;
cr.iterperm = iteration;
if par==1
    cr.par = statset('UseParallel',true);
else
    cr.par = statset('UseParallel',false);
end

% operation
cr.p=[];
cr.h=[];
cr.clustersize=[];
cr.clusterstat=[];
cr.labels=[];


