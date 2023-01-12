function classification = NN_Classification_dataset(trainImages, trainLabels, testImages, testLabels)

classification = zeros(size(testImages,1),1);
for i=1:size(testImages,1)
    testImage = testImages(i,:);
    classification(i,1) = NNTesting_dataset(testImage, trainImages, trainLabels);
end

end
