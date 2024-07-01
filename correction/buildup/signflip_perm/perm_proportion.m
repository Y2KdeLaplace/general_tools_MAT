function perm = perm_proportion(perm,sides)
%PERM_PROPORTION comparing permutated data to null distribution
% calculate p from null distribution
% perm = perm_proportion(perm, sides)
% sides: 'left', 'right', 'both'
% Updated by Yiheng Hu (2024.6.30)

dist = perm.dist;
tmp_p = nan(size(dist));
if numel(size(dist))==3
    parfor iter = 1:perm.iterperm
        tmp_p(iter,:,:) = mean(dist>dist(iter,:,:),1);
    end
else
    for iter = 1:perm.iterperm
        tmp_p(iter,:,:) = mean(dist>dist(iter,:,:),1);
    end
end

if strcmp(sides,'right')
    perm.p = tmp_p;
elseif strcmp(sides,'left')
    perm.p = 1-tmp_p;
elseif strcmp(sides,'both')
    perm.p = 2*min(tmp_p,1-tmp_p);
end



