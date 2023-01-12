function prediction = KNNTesting_dataset(testImage, trainImages, trainLabels, K)

% Sets testing image to Sample1
sample1 = testImage;
% Will need to calculate rows and columns
[row, col] = size(sample1);
% images = reshape(images, size(images, 1) * size(images, 2), size(images, 3));
sampleMatrix = reshape(sample1,row*col,1);


% Goes through each image in the training dataset and calculates the 
% Euclidean distance between it and the test image. It returns an array of
% all the Euclidean distances in the training dataset
dEuc = zeros(1, size(trainImages,1));
size(trainImages);
for i=1:size(trainImages,1)
    sample2 = trainImages(i);
    [rows, cols] = size(sample2);
    sample2Matrix = reshape(sample2, rows*cols, 1);
    dEuc(1, i) = EuclideanDistance(sampleMatrix, sample2Matrix);
end

% sorts the array of Euclidean distances by size
[sortedDEuc, indexesArray] = sort(dEuc);
% create empty array to store prediction values
labels = ones(1,K);


% stores the label of the image from the training dataset with the "i"
% smallest Euclidean distance
for i=1:K
    %value = trainData.label{1,indexesArray(i)};
    %99 x 1
    % labels(1,i) = str2double(trainData.label(indexesArray(i),1));
    tester = trainLabels(indexesArray(i),1);
    labels(1,i) = trainLabels(indexesArray(i),1);
    % labels(1,i) = str2double(trainData.label{1,indexesArray(i)});
end

% prediction is the most common value in the matrix
prediction = mode(labels);




end