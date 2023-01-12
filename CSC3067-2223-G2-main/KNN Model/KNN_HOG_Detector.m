clear all
close all

% Loading in testing and training data
[trainImages, trainLabels] = loadFaceImages("face_train.cdataset");
[testImages, testLabels] = loadFaceImages("face_test.cdataset");
testData.images = testImages;
testData.label = testLabels;
trainData.images = trainImages;
trainData.label = trainLabels;

% extracts hog features from the testing and training data
[testData, trainData] = convertData(testData, trainData, "hog");

% Testing the model
classification = KNN_Classification(trainData, testData, 9);

% Display evaluation metrics
[Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1] = evaluate(testData, classification);
showEvaluation(Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1);