function prediction = NNTesting_dataset(testImage, trainImages, trainLabels)

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

% returns the value and index of the image with the smallest Euclidean
% distance
[Value, index] = min(dEuc);
% prediction is the label of the training image saved at ^ index
prediction = trainLabels(index,1);




end