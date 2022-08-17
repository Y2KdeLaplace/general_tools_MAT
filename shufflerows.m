function om = shufflerows(m)
%SHUFFLEROWS 
om = m(shuffle(1:size(m,1)),:);
end

