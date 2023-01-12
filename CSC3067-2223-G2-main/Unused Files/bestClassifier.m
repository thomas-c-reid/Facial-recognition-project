function feature = bestClassifier(classification, labels, weights)

results = zeros(1,486);
for i = 1:486

    total = 0;

    for j = 1:670

        total = total + ((classification(j,i)~=labels(j))*weights(j));

    end
    results(i) = total;
end

bestFeature = find(results==min(results));

random = randi([1,length(bestFeature)]);

feature = bestFeature(random);

end