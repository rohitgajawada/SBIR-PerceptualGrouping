function h = showGrouping(ConSegList, label, path )

addpath(pwd);
load colors.mat;
        
im = imread(path);
img = ones(size(im));
img = logical(img);
h=figure('visible','on','Position',[10,10,size(img,1),size(img,2)]);imshow(img);
num_segs = size(ConSegList,2);
hold on;
        
        for k=1:num_segs
            scatter(ConSegList{1,k}(:,2),ConSegList{1,k}(:,1), 5, colors(mod(label(k),15)+1,:));            
        end
        set(gca,'ydir','reverse');            
        hold off;

end

