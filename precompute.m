clear all; close all;
classes = {'airplane','banana','cannon','cow','duck','hamburger','hermit_crab','kangaroo','owl','rhinoceros','scorpion','mouse','starfish','sword','teddy_bear','umbrella','wheelchair','pineapple','penguin'
};
addpath(genpath('./'));
w = [1.1007 -0.0011]'
C = 0.5;

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
        
        I = uint8(I_out > 0.1);
        try
            SegList  = GetConSeg( I );
        catch
            disp(strcat('got error at 24 for image', char(x)));
            continue
        end

        labels = GestaltGroupRsvm(SegList, w, C);

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
