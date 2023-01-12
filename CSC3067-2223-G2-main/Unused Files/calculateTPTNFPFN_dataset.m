function [TP, TN, FP, FN] = calculateTPTNFPFN_dataset(testLabels, classification)

totalSize = size(testLabels);
 
TP = 0;
FP = 0;
TN = 0;
FN = 0;

for i=1:totalSize
    if testLabels(i,1) == 1 && classification(i,1) == 1
        TP = TP + 1;
    end
end
% True Negative
for i=1:totalSize
    if testLabels(i,1) == -1 && classification(i,1) == -1
        TN = TN + 1;
    end
end
% False Positive
for i=1:totalSize
    if testLabels(i,1) == -1 && classification(i,1) == 1
        FP = FP + 1;
    end
end
% False Negative
for i=1:totalSize
    if testLabels(i,1) == 1 && classification(i,1) == -1
        FN = FN + 1;
    end
end
end
