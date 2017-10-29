function final = energyCalc(I, labels, SegList, thresh)
    
    groups = unique(labels);
    
    num = size(groups, 1);
    temp = zeros(num, size(I, 1), size(I, 2));   
    values = [1: max(labels)];
    
    ifkeep = ones(1, num);
    
    for c = 1: num
        values(groups(c)) = c;
    end

    for l = 1: size(SegList, 2)
        a = SegList{1, l};
        kval = labels(l);
        kval = values(kval);
        
        for c = 1: size(a, 1)
            temp(kval, a(c, 1), a(c, 2)) = 1;
        end
    end

    %disp(size(temp));
    %m = squeeze(temp(1, :, :));
    %disp(m);
    %figure, imshow(m);
    final = zeros(size(I));
    for n = 1: num
        v = squeeze(temp(n,:,:));
        grouplist = GetConSeg(v);
        
        % h = (grouplist, 2);
        h = corner(v);
        h = size(h,1);
        h = h+1;
        
        totallen = 0;
        for z = 1: size(grouplist, 2)
            totallen = totallen + size(grouplist{1, z}, 1);
        end
        
        energy = h / totallen;
        
        if energy > thresh
            ifkeep(n) = 0;
        else
            final = final + v;
        end
    end
    %final = single(final > 0);
    %figure, imshow(final);
end