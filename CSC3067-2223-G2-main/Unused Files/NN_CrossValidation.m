function [cvtrainAccuracy, cvTestAccuracy] = NN_CrossValidation(allData)

tbl = array2table(allData.images);
tbl.Y = allData.label;

rng('default') % For reproducibility
n = length(tbl.Y);

%Holdout Cross Validation
hpartition = cvpartition(n,'Holdout',0.1);
idxTrain = training(hpartition);
tblTrain = tbl(idxTrain,:);
idxNew = test(hpartition);
tblNew = tbl(idxNew,:);

Mdl = fitcknn(tblTrain,'Y');

cvMdl = crossval(Mdl);

%Training
cvtrainError = kfoldLoss(cvMdl);
cvtrainAccuracy = 1-cvtrainError;

%Testing
cvTestError = loss(Mdl,tblNew,'Y');
cvTestAccuracy = 1-cvTestError;

tblTrain = table2array(tblTrain);
if size(tblTrain,2) == 73
    trainData.label = tblTrain(:,73);
    tblTrain(:,73) = [];
    trainData.images = tblTrain;
end
if size(tblTrain, 2) == 2
    trainData.label = tblTrain(:,2);
    tblTrain(:,2) = [];
    trainData.images = tblTrain;
end
if size(tblTrain, 2) == 487
    trainData.label = tblTrain(:,487);
    tblTrain(:,487) = [];
    trainData.images = tblTrain;
end
classification = zeros(size(tblNew,1),1);
for i=1:size(tblNew,1)
    testImage = tblNew(i,:);
    if size(testImage,2) == 73
        testImage = table2array(testImage);
        testImage(73) = [];
    end

    if size(testImage,2) == 2
        testImage = table2array(testImage);
        testImage(2) = [];
    end
    
    if size(testImage,2) == 487
        testImage = table2array(testImage);
        testImage(487) = [];
    end

    if isa(testImage,"table")
        testImage = table2array(testImage);
    end

    classification(i,1) = NNTesting(testImage, trainData);
    % classification(i,1) = predict(Mdl, testImage);
end

evaluate_CV(tblNew, classification);

end