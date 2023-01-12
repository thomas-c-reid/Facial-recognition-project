clear all
close all

facesFileName = 'images\face\*.png';
nonFacesFileName = 'images\non-face\*.png';

allData = loading_training_images(facesFileName, nonFacesFileName);

[trainData, testData] = shuffleStructure(allData);

% disp("Evaluation results for 80/20 split:");
% disp("");
% 
% classification = SVM_Classification(trainData, testData);
% 
% [Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1] = evaluate(testData, classification);
% 
% showEvaluation(Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1);
% 
% disp("");
% disp("Evaluation results for given datasets:");
% disp("")
% 
% [trainImages, trainLabels] = loadFaceImages("face_train.cdataset");
% [testImages, testLabels] = loadFaceImages("face_test.cdataset");
% 
% classification = SVM_Classification_Dataset(trainImages, trainLabels, testImages, testLabels);
% 
% [Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1] = evaluate_dataset(testLabels, classification);
% 
% showEvaluation(Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1);

disp("");
disp("Evaluation results for Cross Validation:");
disp("")

[trainingAcc, testAcc] = SVM_CrossValidation(allData);