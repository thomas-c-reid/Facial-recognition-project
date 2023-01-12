clear all
close all

% Loads in testing and training data
[trainImages, trainLabels] = loadFaceImages("face_train.cdataset");
[testImages, testLabels] = loadFaceImages("face_test.cdataset");
testData.images = testImages;
testData.label = testLabels;
trainData.images = trainImages;
trainData.label = trainLabels;

% extracts gabor data from testing and training images
method = "gabor";
[testData, trainData] = convertData(testData, trainData, method);
PCA = 1;

% performs LDA on training data

[testingeigenVectors, testingeigvalue, testingmeanX, testingXlda] = PrincipalComponentAnalysis(trainData.images,2);
scatter(testingXlda(1,:), testingXlda(2,:), 10, trainData.label)

[eigenVectors, eigenValues, meanX, Xlda] = LDA(trainData.label,[],trainData.images);ak
scatter(Xlda, trainData.label)


scatter(Xlda, trainLabels)
trainData.images = Xlda;



% converts testing images to correct format using data extracted from LDA
for i=1:size(testData.images,1)
    xPCA(i) = (testData.images(i,:) - meanX) * eigenVectors;
end
testData.images = xPCA';


trainData.eigenVectors = eigenVectors;
trainData.eigenValues = eigenValues;
trainData.meanX = meanX;

% Testing the model
classification = NN_Classification(trainData, testData);

% Display evaluation metrics
[Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1] = evaluate(testData, classification);
showEvaluation(Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1);