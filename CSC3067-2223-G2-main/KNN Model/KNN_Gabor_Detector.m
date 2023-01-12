clear all
close all

% Loading in testing and training data
[trainImages, trainLabels] = loadFaceImages("face_train.cdataset");
[testImages, testLabels] = loadFaceImages("face_test.cdataset");
testData.images = testImages;
testData.label = testLabels;
trainData.images = trainImages;
trainData.label = trainLabels;

% extract gabor data from testing and training images
method = "gabor";
[testData, trainData] = convertData(testData, trainData, method);

% Performing LDA on training data
[eigenVectors, eigenValues, meanX, Xlda] = LDA(trainData.label,[],trainData.images); 
trainData.images = Xlda;
trainData.eigenVectors = eigenVectors;
trainData.eigenValues = eigenValues;
trainData.meanX = meanX;

% converting the testing data to the correct format using data gained from
% LDA
for i=1:size(testData.images,1)
    xPCA(i) = (testData.images(i,:) - meanX) * eigenVectors;
end
testData.images = xPCA';

% Testing the model
classification = KNN_Classification(trainData, testData, 9);

% Display evaluation metrics
[Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1] = evaluate(testData, classification);
showEvaluation(Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1);