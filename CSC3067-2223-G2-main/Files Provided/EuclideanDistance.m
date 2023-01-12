function dEuc=EuclideanDistance(sample1, sample2)

dEuc = sqrt(sum (sample1 - sample2).^2);

end
