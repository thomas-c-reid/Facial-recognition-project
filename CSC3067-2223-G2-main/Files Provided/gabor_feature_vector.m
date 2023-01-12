function vector = gabor_feature_vector(image)

load gabor;
image = adapthisteq(image,'Numtiles',[8 3]);
Features135x144 = cell(5,8);
for s = 1:5
    for j = 1:8
        Features135x144{s,j} = abs(ifft2(G{s,j}.*fft2(double(image),32,32),27,18));
    end
end
Features45x48 = cell2mat(Features135x144);
vector = reshape (Features45x48,[1 19440]);

end