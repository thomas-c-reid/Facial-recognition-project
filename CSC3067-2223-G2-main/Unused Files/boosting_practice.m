
% faces = zeros(69,486);
% for i = 1 : 69
%     faces(i,:) = reshape(imread("images/face/" + i + ".png"), [1,486]);
% end


% facesFileName = 'images\face\*.png';
% nonFacesFileName = 'images\non-face\*.png';
% 
% allData = loading_training_images(facesFileName, nonFacesFileName);
% 
% [trainData, testData] = shuffleStructure(allData);
% 
% weight = 1/99;
% 
% model = NNtraining(trainData.images, trainData.label);
% 
% % compare feature
% 
% for i = 1:486
%     med(i) = median(trainData.images(:,i));
% end
% 
% facesIndices = find(trainData.label==1);
% nonFacesIndices = find(trainData.label==0);
% 
% for i = facesIndices
% 
%     faceMedian = median(trainData.images(i));
% 
% end

[images, labels] = loadFaceImages('face_train.cdataset');

faces = images(1:490,:);
nonFaces = images(491:670,:);

medianFaces = zeros(1,486);
for i = 1:486
    medianFaces(i) = median(faces(:,i));
end

medianNonFaces = zeros(1,486);
for i = 1:486
    medianNonFaces(i) = median(nonFaces(:,i));
end

classification = zeros(670,486);
for i = 1:670

    for j = 1:486

        if ( abs(median(images(i,j)) - medianFaces(j)) <= abs(median(images(i, j) - medianNonFaces(j))))
            classification(i,j) = 1;
        else
            classification(i,j) = -1;
        end
    end

end

weights = zeros(1,670);
weights(1,:) = 1/670;

e = 0;

storeFeatures = [];

valid = true;

while valid == true

    tempE = e;

    bestFeature = bestClassifier(classification, labels, weights);

    [weights, e, storeFeatures] = calculateNewWeights(bestFeature, classification, weights, labels, storeFeatures);

    if (e < tempE)
        valid = false;
    end

end

[images, labels] = loadFaceImages("face_test.cdataset");

for i = 1:10
    result = 0;
    for j = 1:length(storeFeatures)
        result = result + images(i,storeFeatures(j,1)) * storeFeatures(j,2);
    end
    result
end

%Work in progress - not giving  ideal result