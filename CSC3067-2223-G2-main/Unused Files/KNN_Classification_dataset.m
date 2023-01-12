function classification = KNN_Classification_dataset(trainImages, trainLabels, testImages, testLabels, K)

classification = zeros(size(testImages,1),1);
for i=1:size(testImages,1)
    testImage = testImages(i,:);
    classification(i,1) = KNNTesting_dataset(testImage, trainImages, trainLabels, K);
end

end
