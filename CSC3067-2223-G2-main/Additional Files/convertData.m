function [testData,trainData] = convertData(testData, trainData, method)
% convert to allData.testImages and allData.trainImages
% enhance each images contrast
% get Gabor features of each file
% use PCA
% ------------------------------------------------------ Make function
rows = 27;
cols = 18;

for i=1:size(testData.images,1)
    matrix = testData.images(i,:);
    image = uint8(reshape(matrix,[rows, cols]));
    % reshape and convert to image
    image = enhanceContrastHE(image);
    processedimages{i} = image;
end
testData.images = processedimages;

for i=1:size(trainData.images)
    matrix = trainData.images(i,:);
    image = uint8(reshape(matrix,[rows, cols]));
    % reshape and convert to image
    image = enhanceContrastHE(image);
    processedimages{i} = image;
end
trainData.images = processedimages;

% get rid of historgram coming up

switch method
    case "hog"
        dataSize = size(testData.images,2);
        for i=1:dataSize
            hogImage = hog_feature_vector(testData.images{1,i});
            images(i,:) = hogImage;
        end
        testData.images = images;

        dataSize = size(trainData.images,2);
        for i=1:dataSize
            hogImage = hog_feature_vector(trainData.images{1,i});
            images(i,:) = hogImage;
        end
        trainData.images = images;

    case "gabor"
        dataSize = size(testData.images,2);
        for i=1:dataSize
            gaborImage = gabor_feature_vector(testData.images{1,i});
            images(i,:) = gaborImage;
        end
        testData.images = images;

        dataSize = size(trainData.images,2);
        for i=1:dataSize
            gaborImage = gabor_feature_vector(trainData.images{1,i});
            images(i,:) = gaborImage;
        end
        trainData.images = images;
    case "fullImage"
        dataSize = size(testData.images,2);
        for i=1:dataSize
            image = testData.images{1,i};
            reshapedImage = double(reshape(image,1,[]));
            images(i,:) = reshapedImage;
        end
        testData.images = images;

        dataSize = size(trainData.images,2);
        for i=1:dataSize
            image = trainData.images{1,i};
            reshapedImage = reshape(image,1,[]);
            images(i,:) = reshapedImage;
        end
        trainData.images = images;

end


end

