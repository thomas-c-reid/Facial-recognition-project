function [] = showEvaluation(Acc, TP, TN, FP, FN, Prec, Rec, Spec, F1)

disp("Recognition Rate: " + Acc);
disp("True Positive: " + TP);
disp("True Negative: " + TN);
disp("False Positive: " + FP);
disp("False Negative: " + FN);
disp("Precision: " + Prec);
disp("Recall: " + Rec);
disp("Specificity: " + Spec);
disp("F1 Score: " + F1);

end