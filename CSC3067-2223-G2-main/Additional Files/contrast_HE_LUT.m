function Lut = contrast_HE_LUT(Iin)
Lut = zeros(1, 256);

for i = 1:256
    Lut(i) = i;
end

[rows, columns] = size(Iin);
noPix = rows * columns;

h = myHistogram(Iin);
CumsumH = cumsum(h);

% this bit needs to change to incorporate y = mx + c
for i = 1:256
    %Lut(i) = round((i^gamma)/255^(gamma-1));
    %output value = max {0,(short)[256 * CH(input value) / (number of pixels in image)] – 1} 
    
    Lut(i) = max(0,round((256*CumsumH(i)/noPix))-1);
end

Lut = uint8(Lut);



end