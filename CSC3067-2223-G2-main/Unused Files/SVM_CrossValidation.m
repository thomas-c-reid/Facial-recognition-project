function [cvtrainAccuracy, cvTestAccuracy] = SVM_CrossValidation(allData, model)

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

Mdl = fitcsvm(tblTrain,'Y');

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
    % classification(i,1) = predict(Mdl, testImage);
    im = table2array(testImage);
    if size(im,1) > 72
        im(73) = [];
    end
    classification(i,1) = SVMTesting(im, model);
end

evaluate_CV(tblNew, classification);

end