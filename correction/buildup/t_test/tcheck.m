function [h,p,stat] = tcheck(alldata,m,sides,alpha)
%TCHECK Summary of this function goes here
% ttest for data with subj*para1*para2 (para can be tp, channel
% etc. e.g. subj*ifreq*itp)
%
% cr = tcheck(alldata,cr,m,sides)
% m: mean value to compare, 0 by default
% sides: 'both' by default, 'left' & 'right'
% H: significant matrix (para1*para2)
% STAT: t value matrix (para1*para2)
% update by Yiheng Hu(2022.12.6)

[htmp,ptmp,~,tmp_stat] = ttest(alldata,m,'Tail',sides,'Alpha',alpha);

h = size_makeup(htmp);
p = size_makeup(ptmp);
stat = size_makeup(tmp_stat.tstat);


