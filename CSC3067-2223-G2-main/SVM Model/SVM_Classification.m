function classification = SVM_Classification(trainData,testData)

model = SVMtraining(trainData.images, trainData.label);

classification = zeros(size(testData.images,1),1);
for i=1:size(testData.images,1)
    testImage = testData.images(i,:);
    answer = SVMTesting(testImage, model);
    classification(i,1) = answer;
end

end