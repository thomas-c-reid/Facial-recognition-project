function Iout = enhanceContrastHE(Iin)

LUT = contrast_HE_LUT(Iin);
Iout = intlut(Iin,LUT);

end