function [eigenVectors, eigenvalues, meanX, Xpca] = PrincipalComponentAnalysis (X, ndim)
%X is a matrix conatining all the training samples 
%the dimensions of X are: number_of_Samples x number_of_features
%ndim is a variable with the number of reduced PCA dimensions we want to obtain

%calculate mean over the samples
% meanX = %////////STEP 1\\\\\\\\\\\\\\\
% X = X';

test1 = size(X,1);

for i=1:size(X,1)
    meanX(i) = mean(X(:,i));
    % mean for each sample
end

%subtract mean to each sample
% A= %////////STEP 1\\\\\\\\\\\\\\\
for i=1:size(X,1)
    % repeat for each sample
    row2subtract = X(1,:);
    % subtract from sample
    tester = meanX(i);
    size2 = size(row2subtract,2);
    for j=1:size2
        val = X(i,j) - tester;
        A(j,i) = val;
    end
end
% calculate covariance of the previous matrix
%S = %////////STEP 2\\\\\\\\\\\\\\\
S = cov(A);
% SampleSize x SampleSize
% tester = svd(S);

% [U, V] = eig(S);
[U, V] = svd(A);
% U = no.Feats x no.Feats
% V = No.Feats x No.Samples
% S = the eigenvalues
% U = the eigenvector
% test = mtimes(S,A);

eigenVectors = U;
if size(V,2) == 1
    eigenvalues = V(1);
else
    eigenvalues = diag(V);
end
% No.Samples x 1

% obtain eigenvalue & eigenvector
% [eigenVectors,D] = eig(S);
% eigenvalues = diag(D);
% sort eigenvalues in descending order
eigenvalues = eigenvalues(end:-1:1);
eigenVectors = fliplr(eigenVectors);


if nargin<2
    % if the user does not tell us how many dimensions he wants:
    % evaluate the number of principal components needed to represent 95% Total variance.
    
    eigsum = cumsum(eigenvalues);
    eigsum = eigsum / eigsum(end);
    
    index = find(eigsum >= 0.95);
    ndim = index(1);
    
end

% return only the desired number of dimensions with the higher eignvalues
% ( higher amount of information)
eigenVectors = eigenVectors(1:ndim,:);
% NDim x No.Features
% eigenVectors = eigenVectors(:,1:ndim);
% eigenVectors2 = rot90(eigenVectors);
if size(eigenvalues,1) > 1
    eigenvalues = eigenvalues(1:ndim);
end
% NDim x 1


% dataset transformed to the pca space:
% Xpca=A*eigenVectors;
Xpca=eigenVectors*A;
% NDim x No.Samples

end