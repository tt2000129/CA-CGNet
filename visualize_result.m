clear all; close all; clc
addpath(genpath('./Utils/'));
%% data params
part_fname = './data/FAUST/6890/tr_reg_080.mat';
part_off_fname = './data/FAUST/6890/tr_reg_080.off';
model_fname = './data/FAUST/6890/tr_reg_085.mat';
model_off_fname = './data/FAUST/6890/tr_reg_085.off';


%%
part = load(part_fname);
part.shape = load_off(part_off_fname);
model = load(model_fname);
model.shape = load_off(model_off_fname);

%% read matches
load('./FMnet/faust_matches/6890/intra/080_085.mat');
% load('./Results/test_list.mat');
% C_est = squeeze(C_est);
% softCorr = squeeze(softCorr);
matches = squeeze(softCorr);
%% plot result
% figure, imagesc(C_est); title('Estimated C');
% [~, matches] = max(softCorr,[],1);
% [~, matches1] = max(softCorr,[],2);

colors = create_colormap(model.shape,model.shape);
figure(2);subplot(1,2,1);colormap(colors);
plot_scalar_map(model.shape,[1: size(model.shape.VERT,1)]');freeze_colors;title('Target');

figure(2);subplot(1,2,2);colormap(colors(matches,:));
plot_scalar_map(part.shape,[1: size(part.shape.VERT,1)]');freeze_colors;title('Source');

% colors = create_colormap(part.shape,part.shape);
% figure(2);subplot(1,2,1);colormap(colors);
% plot_scalar_map(part.shape,[1: size(part.shape.VERT,1)]');freeze_colors;title('Source');
% 
% figure(2);subplot(1,2,2);colormap(colors(matches1',:));
% plot_scalar_map(model.shape,[1: size(model.shape.VERT,1)]');freeze_colors;

% colors = create_colormap(model.shape,model.shape);
% figure(3);subplot(1,2,1);colormap(colors);
% plot_scalar_map(model.shape,[1: size(model.shape.VERT,1)]');freeze_colors;title('Target');
% 
% figure(3);subplot(1,2,2);colormap(colors(matches,:));
% plot_scalar_map(part.shape,[1: size(part.shape.VERT,1)]');freeze_colors;title('Source');
        





