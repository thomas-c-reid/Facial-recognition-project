clear all
close all

% Loading in testing and training data
method = "hog";
[trainImages, trainLabels] = loadFaceImages("face_train.cdataset");
[testImages, testLabels] = loadFaceImages("face_test.cdataset");
testData.images = testImages;
testData.label = testLabels;
trainData.images = trainImages;
trainData.label = trainLabels;

% extracts hog features from testing and training data
[testData, trainData] = convertData(testData, trainData, "hog");

% Creates the model
model = SVMtraining(trainData.images, trainData.label);

% Testing the system
classification = zeros(size(testData.images,1),1);
for i=1:size(testData.images,1)
    testImage = testData.images(i,:);
    answer = SVMTesting(testImage, model);
    classification(i,1) = answer;
end

% Displaying the evaluation metrics
[Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1] = evaluate(testData, classification);
showEvaluation(Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1);