clear all; close all;
% put castle
classes = {'airplane','banana','cannon','cow','duck','hamburger','hermit_crab','kangaroo','owl','rhinoceros','scorpion','mouse','starfish','sword','teddy_bear','umbrella','wheelchair','pineapple','penguin'
};
addpath(genpath('./'));
%load modelBsds.mat;
opt = initialopt;

data_path = './sketchy/photos/';
tic;
whites = 0; num_imgs = 0;
for i=1:numel(classes)
    disp(strcat('Starting class: ', char(classes(i))));
    s = strcat(data_path, classes(i), '/edges/');
    list_struct = dir(char(s));
    for j = 3:numel(list_struct)
        x = strcat(s, list_struct(j).name);
        I = imread(char(x));
        I = uint8(I>200)*255;
        
        whites = whites + (sum(I(:)) / 255);
        num_imgs = num_imgs + 1;
    end
    disp(strcat('Finishing class: ', char(classes(i))));
end
avg_val = whites/num_imgs; % turns out to be 1.6e03
toc;
% airplane, duck
% banana