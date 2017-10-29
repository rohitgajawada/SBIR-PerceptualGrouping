clear all; close all;
% put castle
classes = {'airplane','banana','cannon','cow','duck','hamburger','hermit_crab','kangaroo','owl','rhinoceros','scorpion','mouse','starfish','sword','teddy_bear','umbrella','wheelchair','pineapple','penguin'
};
addpath(genpath('./'));
%load modelBsds.mat;
opt = initialopt;

data_path = './sketchy/photos/';
tic;
for i=1:numel(classes)
    disp(strcat('Starting class: ', char(classes(i))));
    s = strcat(data_path, classes(i), '/edges/');
    list_struct = dir(char(s));
    for j = 3:numel(list_struct)
        x = strcat(s, list_struct(j).name);
        I = imread(char(x));
        I_out = edgethin(I);
        
        % Get curve segments
        I = uint8(I_out > 0.1);
        try
            SegList  = GetConSeg( I );
        catch
            disp(strcat('got error at 24 for image', char(x)));
            continue
        end

        % obtain perceptual grouping result by graph-cuts
        labels = GestaltGroupRsvm( SegList,opt.RelativeImp,opt.C);
        % show grouping result
        %showGrouping(SegList,labels,edges_fname);
        try
            energy_filtered_image = energyCalc(I, labels, SegList, 0.22);
        catch
            disp(strcat('got error at 36 for image', char(x)));
            continue
        end
        %imshow(I_out);
        disp(strcat('Writing Image: ', char(x)));
        imwrite(energy_filtered_image, char(x));
    end
    disp(strcat('Finishing class: ', char(classes(i))));
end
toc;
% airplane, duck
% banana