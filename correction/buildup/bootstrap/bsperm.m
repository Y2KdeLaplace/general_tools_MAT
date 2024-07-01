function perm = bsperm(alldata,perm,u,nbs,alpha)
%TPERM 
% perform permutation and t-test to obtain t, p & h
perm.dist = nan([perm.iterperm,size(alldata,[2,3])]);
perm.p = perm.dist;
perm.h = perm.dist;
[L1, L2] = size(alldata,[2 3]);
L0 = size(alldata,1);

parfor s = 1:perm.iterperm
    tmpdata = alldata.*((-1).^round(rand([L0,1])));
    for i = 1:L1
        for j = 1:L2
            [h_tmp(s,i,j),pbs(s,i,j),meanVal(s,i,j)] = bootstrapStats(tmpdata(:,i,j),...
                nbs,u,alpha);   
        end
    end
end
perm.h = h_tmp;
perm.p = pbs;
perm.dist = meanVal;

end

