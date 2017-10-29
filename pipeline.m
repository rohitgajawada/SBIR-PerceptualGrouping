clear all; close all;
addpath(genpath('./'));
opt = initialopt;

E1 = imread('./sketchy/freeze/banana/edges/n07753592_296.jpg');
E = edgethin(E1);

I = E>0.1;
edges_fname = './edges_thin.png';
imwrite(I, 'edges_thin.png', 'png');
SegList  = GetConSeg( I );

labels = GestaltGroupRsvm( SegList,opt.RelativeImp,opt.C);
showGrouping(SegList,labels,edges_fname); 
f = energyCalc(I, labels, SegList, 0.14);
% imshow(f);

edges_fname = './need/banana/edge_final.png';
imwrite(f,edges_fname, 'png');