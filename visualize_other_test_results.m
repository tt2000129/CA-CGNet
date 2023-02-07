%% Visualize Unsupervised Network Results
clear all; close all; clc

addpath(genpath('./'))
addpath(genpath('./Utils/'))
addpath('./renderTools/MatlabRenderToolbox-master/func_render/')
addpath('./renderTools/MatlabRenderToolbox-master/func_other/')

mesh_dir = '../../data/TOSCA/4096/';
X = load('./capsFMnet/scape_matches/sort_aveerrs.mat');
pairs = X.pairs;
for i=1:size(pairs,1)
%     S1 = MESH_IO.read_shape([mesh_dir, s1_name]);
%     S2 = MESH_IO.read_shape([mesh_dir, s2_name]);
    mesh_0 = load_off(['./data/SCAPE/4096/',pairs{i,1},'.off']); %Choose the indices of the test pair
    mesh_1 = load_off(['./data/SCAPE/4096/',pairs{i,2},'.off']); %Choose the indices of the test pair

    X = load(['./ORCFMnet/scape_matches/4096/',pairs{i,1},'_',pairs{i,2},'.mat']); %Choose the indices of the test pair
    matches = X.matches;
   
    colors = create_colormap(mesh_1,mesh_1);
    figure;
    subplot_tight(1,2,1); colormap(colors);
    plot_scalar_map(mesh_1,[1: size(mesh_1.VERT,1)]');freeze_colors;title('Target'); axis off;

    subplot_tight(1,2,2); colormap(colors(matches,:));
    plot_scalar_map(mesh_0,[1: size(mesh_0.VERT,1)]');freeze_colors;title('Source'); axis off;
end