function allData = loading_training_images(facesFileName,nonFacesFileName)
% you want to take in 2 file names
% return a structure containing an image file location and label beside it

% creates datastore
faces = imageDatastore(facesFileName);
faceImages = readall(faces);
% create array of labels
facesLabel = num2str(ones(size(faces.Files,1),1));
% adds labels to datastore
faces.Labels = facesLabel;


% creates datastore
non_faces = imageDatastore(nonFacesFileName);
nonFaceImages = readall(non_faces);
% create array of labels
nonFacesLabel = num2str(zeros(size(non_faces.Files,1),1));
% adds labels to datastore
non_faces.Labels = nonFacesLabel;


% gets rid of all useless data from datastructre, just files and labels
finishedFaces = [faceImages, faces.Labels];
finishedNonFaces = [nonFaceImages, non_faces.Labels];


% concatenates all data into one array
finalArray = [finishedFaces; finishedNonFaces];

temp.images = finalArray(:,1);
temp.label = finalArray(:,2);

% ==============================================================
% Transforming into proper format
% ==============================================================
dataSize = size(temp.images,1);

for i=1:dataSize
    [rows, cols] = size(temp.images{i,1});
    sampleMatrix = reshape(temp.images{i,1},rows*cols,1);
    sampleMatrix = im2double(sampleMatrix);
    images(i,:) = sampleMatrix;
end

%for labels, turn into 1 by 124
for i=1:dataSize
    val1 = temp.label{i,1};
    labels(i,1) = str2double(val1);
end

allData.images = images;
allData.label = labels;

end

