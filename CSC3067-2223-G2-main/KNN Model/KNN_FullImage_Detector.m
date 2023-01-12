clear all
close all

% Loading in testing and training data
[trainImages, trainLabels] = loadFaceImages("face_train.cdataset");
[testImages, testLabels] = loadFaceImages("face_test.cdataset");
testData.images = testImages;
testData.label = testLabels;
trainData.images = trainImages;
trainData.label = trainLabels;

% converts testing and training data to correct format
method = "fullImage";
[testData, trainData] = convertData(testData, trainData, method);

% Code to test for most effective value of K;
% for k=1:2:21
%     disp(k)
%     classification = KNN_Classification(trainData, testData, k);
%     [Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1] = evaluate(testData, classification);
%     accuracies(count) = Acc;
%     count = count+1;
% end
% plot(accuracies)

% most effective value of K
K = 9;

% Testing the system
classification = KNN_Classification(trainData, testData, K);

% Display evaluation metrics
[Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1] = evaluate(testData, classification);
showEvaluation(Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1);