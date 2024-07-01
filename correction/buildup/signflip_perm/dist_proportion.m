function cr = dist_proportion(cr,perm,sides)
%DIST_PROPORTION comparing data to null distribution
% calculate p from null distribution
% perm = perm_proportion(perm,m,sides)
% perm.dist: nboot*para1*para2
% data: para1*para2
% sides: 'left' & 'right'

tmp_p = squeeze(mean( reshape(reshape(perm.dist,perm.iterperm,[])>reshape(cr.stat,1,[]),size(perm.dist)) ,1));
if strcmp(sides,'right')
    cr.p = tmp_p;
elseif strcmp(sides,'left')
    cr.p = 1-tmp_p;
elseif strcmp(sides,'both')
    cr.p = 2*min(tmp_p,1-tmp_p);
end


