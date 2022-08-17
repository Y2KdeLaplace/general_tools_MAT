function a = shuffle(a)
%SHUFFLE To shuffle a vector
if isvector(a)
    a = a(randperm(length(a)));
end
end
