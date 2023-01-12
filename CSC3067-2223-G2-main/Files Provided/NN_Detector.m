clear all
close all

% ======================================================================
% Training
% ======================================================================

% links to the files containing images
facesFileName = 'images\face\*.png';
nonFacesFileName = 'images\non-face\*.png';

% function created to load data from files into a structure
allData = loading_training_images(facesFileName, nonFacesFileName);

% trainData is essentially modelNN
% testData is a model which contains data to be tested
[trainData, testData] = shuffleStructure(allData);

% ======================================================================
% Testing
% ======================================================================

% Change value of K here
% Tests each image against the training Data to get prediction 
% if the image is a face or not a face
K = 5;
classification = zeros(size(testData.images,1),1);
for i=1:size(testData.images,1)
    testImage = testData.images(i,:);
    classification(i,1) = NNTesting_practice(testImage, trainData);
end

% ======================================================================
% Evaluation
% ======================================================================


v1 = testData.label;
comparison = (testData.label==classification);
val1 = sum(comparison);
val2 = length(comparison);
Accuracy = sum(comparison)/length(comparison)

% returns the amount of correctly identified values
% correct = 0;
% for i=1:size(classification,1)
%     if classification(i,1) == str2double(testData.label{i})
%         correct = correct + 1;
%     end
% end

% Final Accuracy value for model