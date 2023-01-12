function [TP, TN, FP, FN] = calculateTPTNFPFN(testData, classification)
% labels = testData.label;
totalSize = size(testData.label);
 
% comparison = (testData.label==classification);
TP = 0;
FP = 0;
TN = 0;
FN = 0;
% allPositives = find (classification == 1);
% totalPositives = size(allPositives,1);
% allNegatives = find (classification == 0);
% totalNegatives = size(allNegatives,1);
% True Positives
for i=1:totalSize
    if testData.label(i,1) == 1 && classification(i,1) == 1
        TP = TP + 1;
    end
end
% True Negative
for i=1:totalSize
    if testData.label(i,1) == -1 && classification(i,1) == -1
        TN = TN + 1;
    end
end
% False Positive
for i=1:totalSize
    if testData.label(i,1) == -1 && classification(i,1) == 1
        FP = FP + 1;
    end
end
% False Negative
for i=1:totalSize
    if testData.label(i,1) == 1 && classification(i,1) == -1
        FN = FN + 1;
    end
end
end