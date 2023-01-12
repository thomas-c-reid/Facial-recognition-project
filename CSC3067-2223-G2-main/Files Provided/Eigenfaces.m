clear all 
close all 
load Yale_64x64
[nSamples, nDimensions] = size(fea); 

h=64;
w=64;
tempNDim = 15;
% draw the first 9 images 
% //////////STEP 4 \\\\\\\\\\\\\\\\\\\\\\

% Apply PCA
% //////////STEP 5 \\\\\\\\\\\\\\\\\\\\\\
[eigenVectors, eigvalue, meanX, Xlda] = PrincipalComponentAnalysis(fea,tempNDim);


%% show 0th through 15th principal eigenvectors 
eig0 = reshape(meanX, [64, 64]); 
figure,subplot(4,4,1) 
imagesc(eig0) 
colormap gray 
eigVector_index = 1;
for i = 1:15 
    subplot(4,4,i+1) 
    eigTempx = eigenVectors(i,:);
    eigTempx = flip(eigTempx);
    eigTemp = eigenVectors(:,i);
    testerEigenValue = (eigvalue(i));
    eigTemp3 = eigTemp * testerEigenValue;
    eigTemp2 = eigTemp*(1/(eigvalue(i)));
    weights = [-3*sqrt(eigvalue(eigVector_index)): 6*sqrt(eigvalue(eigVector_index))/200: 3*sqrt(eigvalue(eigVector_index))];
    imagesc(reshape(eigTempx,h,w)) 
    % imagesc(reshape(eigTemp,h,w)) 
end

gsgds = 5;

%%
%animation for observing the variation of the first eigenvector
%////////////////////// STEP 7 \\\\\\\\\\\\\\\\\\\\\\\\\\

