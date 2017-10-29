i1 = im2double(imread('./testimgs/duckfinal.jpg'));
i2 = im2double(imread('./testimgs/frogfinal.jpg'));
i3 = im2double(imread('./testimgs/jackfinal.jpg'));
i4 = im2double(imread('./testimgs/ducksketch.png'));
i5 = im2double(imread('./testimgs/frogsketch.png'));
i6 = im2double(imread('./testimgs/jacksketch.png'));

a=zeros(1,9);
a(1)=hoghist(i1, i4);
a(2)=hoghist(i1, i5);
a(3)=hoghist(i1, i6);

a(4)=hoghist(i2, i4);
a(5)=hoghist(i2, i5);
a(6)=hoghist(i2, i6);

a(7)=hoghist(i3, i4);
a(8)=hoghist(i3, i5);
a(9)=hoghist(i3, i6);
