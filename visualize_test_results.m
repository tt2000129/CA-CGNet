%% Visualize Unsupervised Network Results
clear all; close all; clc

addpath(genpath('./'))
addpath(genpath('./Utils/'))
addpath('./MatlabRenderToolbox-master/func_render/')
addpath('./MatlabRenderToolbox-master/func_other/')

mesh_dir = './data/KIDS/resample/';
s1_name = '1_02.off';
s2_name = '1_08.off';
%% Given a pair of shapes, and a computed pair from S1 to S2
% we want to visualize the map by color transfer
S1 = MESH_IO.read_shape([mesh_dir, s1_name]);
S2 = MESH_IO.read_shape([mesh_dir, s2_name]);
% X = load('./SORCNet_new/scape_matches/4096/1_08_1_10.mat'); %Choose the indices of the test pair
% matches = X.matches;
% T12 = matches;
T12 = 1:length(S1.surface.X);
[S1_col,S2_col]= get_mapped_face_color_withNaN(S1,S2,T12,[-2,-1,3]);
% [S1_col,S2_col]= get_mapped_face_color_withNaN(S1,S2,T12,[1,2,3]);
% S1_col = create_colormap(S2.surface,S2.surface);
% S2_col = S1_col(matches,:);

figure(1);
[~,~, S1_new] = render_mesh(S1,'MeshVtxColor',S1_col,...
    'RotationOps',{[-90,0,0],[0,0,30]},...
    'CameraPos',[-10,10],...
    'FaceAlpha',0.9); 
hold on;

figure(2);
translation = [1.2,-0.1,0]; % translate the second shape
[~,~, S2_new] = render_mesh(S2,'MeshVtxColor',S2_col,...
    'RotationOps',{[-90,0,0],[0,0,30]},...
    'VtxPos',S2.surface.VERT + repmat(translation,S2.nv,1),... % translate the second shape such that S1 and S2 are not overlapped
    'CameraPos',[-10,10],...
    'FaceAlpha',0.9);

%% simple visual
% mesh_0 = load_off('./data/FAUST/6890/tr_reg_084.off'); %Choose the indices of the test pair
% mesh_1 = load_off('./data/FAUST/6890/tr_reg_098.off'); %Choose the indices of the test pair
% 
% X = load('./capsFMnet/faust_matches/6890/inter/084_098.mat'); %Choose the indices of the test pair
% matches = X.matches;
% 
% colors = create_colormap(mesh_1,mesh_1);
% figure;
% subplot_tight(1,2,1); colormap(colors);
% plot_scalar_map(mesh_1,[1: size(mesh_1.VERT,1)]');freeze_colors;title('Target'); axis off;
% 
% subplot_tight(1,2,2); colormap(colors(matches,:));
% plot_scalar_map(mesh_0,[1: size(mesh_0.VERT,1)]');freeze_colors;title('Source'); axis off;
