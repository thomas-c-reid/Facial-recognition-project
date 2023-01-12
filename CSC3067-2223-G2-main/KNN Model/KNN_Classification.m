function classification = KNN_Classification(trainData, testData, K)

classification = zeros(size(testData.images,1),1);
for i=1:size(testData.images,1)
    testImage = testData.images(i,:);
    classification(i,1) = KNNTesting(testImage, trainData,K);
end

end