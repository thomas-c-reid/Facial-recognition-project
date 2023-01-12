% clear all
% close all
% 
% % ======================================================================
% % Training
% % ======================================================================
% 
% % links to the files containing images
% facesFileName = 'images\face\*.png';
% nonFacesFileName = 'images\non-face\*.png';
% 
% % function created to load data from files into a structure
% allData = loading_training_images(facesFileName, nonFacesFileName);
% 
% % trainData is essentially modelNN
% % testData is a model which contains data to be tested
% [trainData, testData] = shuffleStructure(allData);

% % ======================================================================
% % Testing
% % ======================================================================
% 
% classification = NN_Classification(trainData, testData);
% 
% % ======================================================================
% % Evaluation
% % ======================================================================
% 
% disp("Evaluation results for 80/20 split:");
% disp(" ");
% 
% [Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1] = evaluate(testData, classification);
% 
% showEvaluation(Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1);
% 
% disp(" ");
% disp("Evaluation results for given datasets:");
% disp(" ")
% 
[trainImages, trainLabels] = loadFaceImages("face_train.cdataset");
[testImages, testLabels] = loadFaceImages("face_test.cdataset");
% 
% 
% classification = NN_Classification_dataset(trainImages, trainLabels, testImages, testLabels);
% 
% [Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1] = evaluate_dataset(testLabels, classification);
% 
% showEvaluation(Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1);

disp("");
disp("Evaluation results for Cross Validation:");
disp("")

[trainingAcc, testAcc] = NN_CrossValidation(allData);