function [trainData, testData] = shuffleStructure(allData);

% save the images and labels in two seperate arrays
% create array of integers from 1-length of array

imagesToShuffle = allData.images;
% 124 x 486
labelsToShuffle = allData.label;
% 124 x 1


maxVal = size(imagesToShuffle,1);
order = 1:maxVal;
N = 1000;

% N = 1000;
% maxLength = length(allData.images);
% order = 1:maxLength;

for i=1:N
    firstIndex = randi(maxVal);
    secondIndex = randi(maxVal);
    
    firstValue = order(firstIndex);
    secondValue = order(secondIndex);

    order(firstIndex) = secondValue;
    order(secondIndex) = firstValue; 

end

trainNumber = round((maxVal/5)*4);
testNumber = maxVal - trainNumber;

trainOrder = order(1:trainNumber);
testOrder = order((trainNumber+1): maxVal);


for i=1:trainNumber
    trainData.images(i,:) = imagesToShuffle(trainOrder(i),:);
    trainData.label(i,:) = labelsToShuffle(trainOrder(i),:);
%     trainData.images(i) = allData.images(trainOrder(i));
%     trainData.label(i) = allData.label(trainOrder(i));
end

for i=1:testNumber
    testData.images(i,:) = imagesToShuffle(testOrder(i),:);
    testData.label(i,:) = labelsToShuffle(testOrder(i),:);
%     testData.images(i) = allData.images(testOrder(i));
%     testData.label(i) = allData.label(testOrder(i));
end



end