function [Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1] = evaluate_dataset(testLabels, classification)

comparison = (testLabels==classification);
Acc = sum(comparison)/length(comparison);

[TP, TN, FP, FN] = calculateTPTNFPFN_dataset(testLabels, classification);

% Precision = number of positive identifications correctly classified
Prec = TP/(TP+FP);
% Recall = What proportion of actual positives was identified correctly
Rec = TP/(TP+FN);
% Specificity = proportion of actual negatives, which got predicted as the negative
Spec = TN/(TN + FP);
% F1 score = harmonic mean of precision and recall
F1 = 2 * ((Prec*Rec)/(Prec+Rec));

end