function perm = signflip(perm,alldata,iteration)
%SIGNFLIP 
% do permutation by multiplying data with -1 randomly in a
% binary distribution
% perm_mu = randopposite_mu(obj,times)
% perm_mu: iter*para1*para2

nsample = size(alldata,1);
perm_mu = nan([iteration,size(alldata,[2,3])]);
parfor i = 1:iteration
    perm_mu(i,:,:) = mean(alldata.*((-1).^round(rand(nsample,1))),1);
end
perm.dist = perm_mu;


