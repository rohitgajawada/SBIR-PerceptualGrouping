clear all; close all;
%cow
classes = {'sword','airplane','cow','kangaroo','cannon','scorpion','starfish','banana','duck','hamburger','hermit_crab','owl','rhinoceros','mouse','umbrella','wheelchair','pineapple','penguin','teddy_bear'};
addpath(genpath('./'));
counter = 1;
sketch_path = './sketchqueries/';
for i=1:numel(classes)
    disp(strcat('Starting class: ', char(classes(i))));
    class_folder = strcat(sketch_path, classes(i), '/');
    sk_list = dir(char(class_folder));
    for j = 3:numel(sk_list)
        query_sk = strcat(class_folder, sk_list(j).name);
        q_sketch = rgb2gray(imread(char(query_sk)));
        q_sketch = 255 - q_sketch;
        
        min_dist = 1e10; closest_img = ''; closest_label = 0;
        
        data_path = './sketchy/photos/';
        for k = 1:numel(classes)
            class_data = strcat(data_path, classes(k), '/edges/');
            data_imgs = dir(char(class_data));
            for l = 3:numel(data_imgs)
                full_path = char(strcat(class_data, data_imgs(l).name));
                d_image = imread(full_path);
                
                thresh_d = uint8(d_image > 100)*255;
                num_whites = sum(thresh_d(:)) / 255;
                if num_whites < 700
                    %disp(num2str(num_whites));
                    %disp(char(classes(k)));
                    %disp(full_path);
                    continue
                end
                
                %figure; subplot(1,2,1); imshow(q_sketch);
                %subplot(1,2,2); imshow(d_image);
                %wait;
                
                distance = hoghist(q_sketch, d_image);
                
                if distance < min_dist
                    min_dist = distance;
                    closest_label = k;
                    closest_img = strcat(data_path, classes(closest_label), '/', data_imgs(l).name);
                end
            end
        end
        set(0,'DefaultFigureVisible','off');
        f = figure; subplot(1,2,1); imshow(q_sketch);
        disp(char(closest_img));
        subplot(1,2,2), imshow(char(closest_img));
        saveas(f, char(strcat('./results/',char(classes(i)),'_',num2str(counter) , '.jpg')));
        close(f);
        counter = counter+1;
    end
end