function [images, labels] = transformData(allData)

% allData is a structure
% images = 124x1 (27x18)
% should output a 486x124 array. Each image is a column

% [rows, cols] = size(allData.images);
dataSize = size(allData.images,1);

for i=1:dataSize
    [rows, cols] = size(allData.images{i,1});
    sampleMatrix = reshape(allData.images{i,1},rows*cols,1);
    sampleMatrix = im2double(sampleMatrix);
    images(i,:) = sampleMatrix;
end

%for labels, turn into 1 by 124
for i=1:dataSize
    val1 = allData.label{i,1};
    labels(i,1) = str2double(val1);
    % labels(1,i) = allData.label{i,1};
end

end