clear all
close all

addpath('Additional Files\') 
addpath('detection test images\') 
addpath('Files Provided\') 
addpath('images\') 
addpath('KNN model\') 
addpath('SVM-KM\') 
addpath('SVM model\') 

% Loading in testing and training data
method = "gabor";
[trainImages, trainLabels] = loadFaceImages("face_train.cdataset");
[testImages, testLabels] = loadFaceImages("face_test.cdataset");
testData.images = testImages;
testData.label = testLabels;
trainData.images = trainImages;
trainData.label = trainLabels;

% Extract gabor features from training data
[testData, trainData] = convertData(testData, trainData, "gabor");

% perform LDA on training data
[eigenVectors, eigenValues, meanX, Xlda] = LDA(trainData.label,[],trainData.images); 
trainData.images = Xlda;

% Creates SVM training model
model = SVMtraining(trainData.images, trainData.label);
model.eigenVectors = eigenVectors;
model.meanX = meanX;

% =========================================================================
% Detector implementation
% =========================================================================


%Loading in test images
image1 = "im1.jpg";
image2 = "im2.jpg";
image3 = "im3.jpg";
image4 = "im4.jpg";
Picture = imread(image2);
Picture = Picture(:,:,1);

% Loading in model

SVMModel = model;
Modelcols = 18;
Modelrows = 27;

% calculating size and scales
ScaleWidth = size(Picture,2)/Modelcols;
ScaleHeight = size(Picture,1)/Modelrows;
if(ScaleHeight < ScaleWidth )
    StartScale =  ScaleHeight; 
else
    StartScale = ScaleWidth;
end

% Sliding window implementation
Objects=zeros(100,5); n=0; 
Options=struct('ScaleUpdate',1/1.2,'Resize',true,'Verbose',true);
itt=ceil(log(1/StartScale)/log(Options.ScaleUpdate));
finalObjects = [];
for i=1:itt
    tempObjects = [];
    Scale =StartScale*Options.ScaleUpdate^(i-1);    
    
    % Window size scales, with decreasing search-scale
    % (instead of cpu-intensive scaling of the image and calculation 
    % of new integral images)
    h = floor(Modelrows*Scale);
    w = floor(Modelcols*Scale);
    
    % Spacing between search coordinates of the image.
    step = floor(max( Scale, 2 ));
    
    % Make vectors with all search image coordinates used for the current
    [x,y]=ndgrid(0:step:(size(Picture,2)-w-1),0:step:(size(Picture,1)-h-1)); x=x(:); y=y(:);
            
    % If no coordinates due to large step size, continue to next scale
    if(isempty(x)), continue; end
        
    % Find objects in the image for the current scale
    PCA = 1;
    Objects = slidingWindowDetection(x, y, Scale, Picture, w, h, SVMModel, PCA, method);
    count = 1;
    % deletes any empty rows from the objects array
    for h=i:size(Objects,1)
        if Objects(h,1) ~= 0 || Objects(h,2) ~= 0 || Objects(h,4) ~= 0 || Objects(h,4) ~= 0
            tempObjects(count, :) = Objects(h,:);
            count = count+1;
        end
    end
    finalObjects = [finalObjects;tempObjects];
end
% Show results pre NMS and post NMS
% Will need to whittle down to just one number, of run an ROC curve
ShowDetectionResult(Picture, finalObjects)
for i=1:10
    disp(i)
    objects = simpleNMS(finalObjects, (i/10));
    ShowDetectionResult(Picture, objects)
end