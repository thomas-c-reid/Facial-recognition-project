function [weights, e, storeFeatures] = calculateNewWeights(bestFeature, classification, weights, labels, storeFeatures)

e = 0;
for i = 1:670

    if classification(i,bestFeature)~=labels(i)

        e = e + weights(i);

    end

end

e = e / sum(weights);

a = 1/2*(log((1-e)/e));

for i = 1:670

    if classification(i,bestFeature)==labels(i)

        weights(i) = weights(i) * exp(-1*a*1);
    else
        weights(i) = weights(i) * exp(-1*a*-1);

    end

end

storeFeatures = [storeFeatures; bestFeature, a];

end