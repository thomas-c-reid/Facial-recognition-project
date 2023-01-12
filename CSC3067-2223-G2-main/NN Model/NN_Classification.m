function classification = NN_Classification(trainData, testData)

classification = zeros(size(testData.images,1),1);
for i=1:size(testData.images,1)
    testImage = testData.images(i,:);
    classification(i,1) = NNTesting(testImage, trainData);
end

end