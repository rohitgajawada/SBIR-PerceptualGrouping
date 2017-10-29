function E = edgethin(I)
    x = im2single(I);

    E=convTri(x,1);
    [Ox,Oy]=gradient2(convTri(E,4));
    [Oxx,~]=gradient2(Ox); [Oxy,Oyy]=gradient2(Oy);
    O=mod(atan(Oyy.*sign(-Oxy)./(Oxx+1e-5)),pi);
    E=edgesNmsMex(E,O,1,5,1.01,4);

    E = uint8(E*255);

end