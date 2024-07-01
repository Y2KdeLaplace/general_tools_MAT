function perm = bsperm_feature(alldata,perm,u,nbs,alpha)
%TPERM 
% perform permutation and t-test to obtain t, p & h
perm.dist = nan([perm.iterperm,size(alldata,[2,3])]);
perm.p = perm.dist;
perm.h = perm.dist;
[L1, L2] = size(alldata,[2 3]);
L0 = size(alldata,1);
for i = 1:L1
    for j = 1:L2
        tmpdata = squeeze(alldata(:,i,j));
        parfor s = 1:perm.iterperm
            this_perm = tmpdata.*((-1).^round(rand([L0,1])));
            [h_tmp(s),pbs(s),meanVal(s)] = bootstrapStats(this_perm,...
                nbs,u,alpha);       
        end

        perm.h(:,i,j) = h_tmp;
        perm.p(:,i,j) = pbs;
        perm.dist(:,i,j) = meanVal;
        clear h_tmp pbs meanVal  
    end
end


end

