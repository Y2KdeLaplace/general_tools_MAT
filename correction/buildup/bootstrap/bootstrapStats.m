function [h,p,meanVal] = bootstrapStats(sample,nbs,baseline,threshold)

% sample: 1D data (size of sample usually = number of subjects)
% nbs: number of bootstapping-generated new samples
% baseline: 1-sided comparsison against the baseline value (usually = 0/chance level)

% Modified by LSY 2022 Nov 22
% debug:
% modified variate name - size > sample_size

sample_size = length(sample);
data_bs = nan(sample_size,nbs);
for i = 1:sample_size
    data_bs(i,:)= sample(randsample(1:sample_size,nbs,true));
end
data_bs_avg = mean(data_bs,1);

p = sum(data_bs_avg < baseline)/nbs;
if p < threshold
    h = 1;
else
    h = 0;
end
meanVal = mean(data_bs_avg);

end