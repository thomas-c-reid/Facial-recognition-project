clear all
close all

% Loads in testing and training data
[trainImages, trainLabels] = loadFaceImages("face_train.cdataset");
[testImages, testLabels] = loadFaceImages("face_test.cdataset");
testData.images = testImages;
testData.label = testLabels;
trainData.images = trainImages;
trainData.label = trainLabels;

% extracts hog features from testing and training data
method = "hog";
[testData, trainData] = convertData(testData, trainData, method);
PCA = 0;

% Testing the model
classification = NN_Classification(trainData, testData);

% Display evaluation metrics
[Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1] = evaluate(testData, classification);
showEvaluation(Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1);