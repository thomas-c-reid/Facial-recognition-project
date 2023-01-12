function classification = SVM_Classification_Dataset(trainImages, trainLabels, testImages, testLabels)

model = SVMtraining(trainImages, trainLabels);

classification = zeros(size(testImages, 1),1);
for i=1:size(testImages,1)
    testImage = testImages(i,:);
    answer = SVMTesting(testImage, model);
    classification(i,1) = answer;
end

end