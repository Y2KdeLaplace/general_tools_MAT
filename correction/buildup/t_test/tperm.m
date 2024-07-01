function perm = tperm(alldata, perm, m, sides, alpha)
%TPERM 
% perform permutation and t-test to obtain t, p & h
perm.dist = nan([perm.iterperm,size(alldata,[2,3])]);
perm.p = perm.dist;
perm.h = perm.dist;

parfor iter = 1:perm.iterperm
    perm_index = (-1).^round(rand([size(alldata,1),1]));
    [htmp(iter,:,:),ptmp(iter,:,:),~,tmp_stat] = ttest(alldata.*perm_index,m,'Tail',sides,'Alpha',alpha);
    t_tmp(iter,:,:) = tmp_stat.tstat;
end

perm.h = squeeze(htmp);
perm.p = squeeze(ptmp);
perm.dist = squeeze(t_tmp);
clear htmp ptmp t_tmp

end
