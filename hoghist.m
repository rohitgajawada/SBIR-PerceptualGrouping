function d = hoghist(img1, img2)
    [feat1, viz1] = extractHOGFeatures(img1);
    [feat2, viz2] = extractHOGFeatures(img2);
    
    feat1 = feat1 / size(img1, 1) / size(img1, 2);
    feat2 = feat2 / size(img2, 1) / size(img2, 2);
    
    d = pdist2(feat1,feat2, 'chisq');
end