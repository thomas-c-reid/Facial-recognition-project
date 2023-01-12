clear all
close all


% Loading in testing and training data
method = "gabor";
[trainImages, trainLabels] = loadFaceImages("face_train.cdataset");
[testImages, testLabels] = loadFaceImages("face_test.cdataset");
testData.images = testImages;
testData.label = testLabels;
trainData.images = trainImages;
trainData.label = trainLabels;

% Extracting Gabor features from testing and training data
[testData, trainData] = convertData(testData, trainData, "gabor");

% Perform LDA on training data
[eigenVectors, eigenValues, meanX, Xlda] = LDA(trainData.label,[],trainData.images); 
trainData.images = Xlda;

% Calculate testing data values based off data gather from performing LDA
for i=1:size(testData.images,1)
    xPCA(i) = (testData.images(i,:) - meanX) * eigenVectors;
end
testData.images = xPCA';
% Creating the model
model = SVMtraining(trainData.images, trainData.label);
model.eigenVectors = eigenVectors;
model.eigenValues = eigenValues;
model.meanX = meanX;

% Testing the system
classification = zeros(size(testData.images,1),1);
for i=1:size(testData.images,1)
    testImage = testData.images(i,:);
    answer = SVMTesting(testImage, model);
    classification(i,1) = answer;
end

% Showing Evaluation metrics
[Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1] = evaluate(testData, classification);
showEvaluation(Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1);