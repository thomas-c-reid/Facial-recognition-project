clear all
close all

% Load in testing and training data
method = "fullImage";
[trainImages, trainLabels] = loadFaceImages("face_train.cdataset");
[testImages, testLabels] = loadFaceImages("face_test.cdataset");
testData.images = testImages;
testData.label = testLabels;
trainData.images = trainImages;
trainData.label = trainLabels;

% Convert data to appropriate format
[testData, trainData] = convertData(testData, trainData, "fullImage");

% build the model
model = SVMtraining(trainData.images, trainData.label);

% Testing the system
classification = zeros(size(testData.images,1),1);
for i=1:size(testData.images,1)
    testImage = testData.images(i,:);
    answer = SVMTesting(testImage, model);
    classification(i,1) = answer;
end

% calculate metrics
[Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1] = evaluate(testData, classification);
showEvaluation(Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1);