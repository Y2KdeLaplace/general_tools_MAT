function cr = bootstrapCheck(cr,alldata,nbs,u,alpha)
% bootstrapping for data with subj*para1*para2 (para can be tp, channel
% etc. e.g. subj*ifreq*itp), calculating 1-sided p values to find clusters
%
% cr = bootstrapCheck(alldata,cr,nbs,u,alpha)
% u: mean value to compare, 0 by default
% H: significant matrix (para1*para2)
% STAT: value matrix (para1*para2)

% Modified by LSY 2022 Nov 22

len = size(alldata,[2 3]);
if cr.par.UseParallel
    L=len(2);
    parfor i = 1:len(1)
        for j = 1:L
            [h_tmp(i,j),pbs(i,j),meanVal(i,j)] = bootstrapStats(squeeze(alldata(:,i,j)),...
                nbs,u,alpha);
        end
    end
    cr.h = h_tmp;
    cr.stat = meanVal;
    cr.p = pbs;
else
    cr.stat = nan(len);
    cr.h = cr.stat;
    cr.p = cr.stat;
    for i = 1:len(1)
        for j = 1:len(2)
            [cr.h(i,j),cr.p(i,j),cr.stat(i,j)] = bootstrapStats(squeeze(alldata(:,i,j)),...
                nbs,baseline,alpha);
        end
    end
end
end

