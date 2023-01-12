function h = myHistogram(I)
H1 = histogram(I, 'BinLimits', [0 256], 'BinWidth',1);
h = H1.Values;
end