function [prediction maxi]= SVMTesting(image,model)

if strcmp(model.type,'binary')
    
    % pred = svmval(image,model.xsup,model.w,model.w0,model.param.kernel,model.param.kerneloption);
    kerneloption.matrix=svmkernel(image,'gaussian',model.param.sigmakernel,model.xsup);
    pred = svmval(image,model.xsup,model.w,model.w0,model.param.kernel,kerneloption);
    if pred>0
        prediction = 1;
    else
        prediction = -1;
    end
    
    maxi=pred;
    
else
    
    [pred maxi] = svmmultival(image,model.xsup,model.w,model.b,model.nbsv,model.param.kernel,model.param.kerneloption);

     prediction = round(pred)-1;
    
end
    
end