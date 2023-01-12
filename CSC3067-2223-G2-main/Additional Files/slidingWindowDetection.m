function Objects = slidingWindowDetection(x, y, Scale, Picture, w, h, model, PCA, method)

val2 = 1/Scale;

% in this area capture the zone of the image
% convert it to the correct size and format
% test out
Objects = zeros(size(x,1), 4);
for i=1:size(x,1)
    % disp(i)
    area3 = Picture(y(i) + 1:(y(i) + h), x(i) + 1:(x(i)+w));
    im = uint8(area3);
    test = imresize(im, val2, "nearest");
    image = enhanceContrastHE(test);
    switch method
    case "gabor"
        Image = gabor_feature_vector(image);
    case "hog"
        Image = hog_feature_vector(image);
    case "fullImage"
        Image = double(reshape(image,1,[]));

    end
    if PCA ==1
        xPCA = (Image - model.meanX) * model.eigenVectors;
        [pred, maxi] = SVMTesting(xPCA, model);
    else
        [pred, maxi] = SVMTesting(Image, model);
    end
    if pred == 1
        val = [x(i), y(i), w, h, maxi];
        Objects(i, 1:5) = val;
    end
end


end