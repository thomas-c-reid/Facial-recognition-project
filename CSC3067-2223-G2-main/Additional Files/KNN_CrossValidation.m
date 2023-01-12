function [cvtrainAccuracy, cvTestAccuracy] = KNN_CrossValidation(allData, K)

tbl = array2table(allData.images);
tbl.Y = allData.label;

rng('default') % For reproducibility
n = length(tbl.Y);

%Holdout Cross Validation
% hpartition = cvpartition(n,'KFold',5);
hpartition = cvpartition(n,'Holdout',0.2);
idxTrain = training(hpartition);
tblTrain = tbl(idxTrain,:);
idxNew = test(hpartition);
tblNew = tbl(idxNew,:);

Mdl = fitcknn(tblTrain,'Y', 'NumNeighbors', K);

cvMdl = crossval(Mdl);

%Training
cvtrainError = kfoldLoss(cvMdl);
cvtrainAccuracy = 1-cvtrainError;

%Testing
cvTestError = loss(Mdl,tblNew,'Y');
cvTestAccuracy = 1-cvTestError;

classification = zeros(size(tblNew,1),1);
for i=1:size(tblNew,1)
    testImage = tblNew(i,:);
    classification(i,1) = predict(Mdl, testImage);
end

evaluate_CV(tblNew, classification);

end