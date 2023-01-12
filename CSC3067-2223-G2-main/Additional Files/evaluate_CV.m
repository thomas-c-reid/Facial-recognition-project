function [Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1] = evaluate_CV(tblTest, classification)

correct = 0;
for i=1:size(tblTest.Y,1)
    if tblTest.Y(i,1) == classification(i,1)
        correct = correct + 1;
    end
end
Acc = correct/length(classification);

totalSize = size(tblTest.Y,1);

TP = 0;
FP = 0;
TN = 0;
FN = 0;

for i=1:totalSize
    if tblTest.Y(i,1) == 1 && classification(i,1) == 1
        TP = TP + 1;
    end
end
% True Negative
for i=1:totalSize
    if tblTest.Y(i,1) == -1 && classification(i,1) == -1
        TN = TN + 1;
    end
end
% False Positive
for i=1:totalSize
    if tblTest.Y(i,1) == -1 && classification(i,1) == 1
        FP = FP + 1;
    end
end
% False Negative
for i=1:totalSize
    if tblTest.Y(i,1) == 1 && classification(i,1) == -1
        FN = FN + 1;
    end
end

% Precision = number of positive identifications correctly classified
Prec = TP/(TP+FP);
% Recall = What proportion of actual positives was identified correctly
Rec = TP/(TP+FN);
% Specificity = proportion of actual negatives, which got predicted as the negative
Spec = TN/(TN + FP);
% F1 score = harmonic mean of precision and recall
F1 = 2 * ((Prec*Rec)/(Prec+Rec));

showEvaluation(Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1);

end