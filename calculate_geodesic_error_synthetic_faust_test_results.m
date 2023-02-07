%% Calculate geodesic error curves
clear all; close all; clc

addpath(genpath('./'))
addpath(genpath('./../Tools/'))

mesh_0 = load('./data/SCAPE/4096/mesh000'); %Choose the indices of the test pair
mesh_1 = load('./data/SCAPE/4096/mesh046'); %Choose the indices of the test pair

X = load('./capsFMnet/scape_matches/4096/mesh000_mesh046.mat'); %Choose the indices of the test pair
matches = X.matches;
% [~, matches] = max(squeeze(X.softCorr),[],1);

D_model = load('./data/SCAPE/4096/distance_maps/mesh046.mat'); %Choose the indices of the test pair
D_model = D_model.D;

gt_matches = 1:6890;
errs = calc_geo_err(matches, gt_matches, D_model);
curve = calc_err_curve(errs, 0:0.001:1.0)/100;
save('./capsFMnet/scape_matches/curve_mesh000_mesh046.mat','curve');
plot(0:0.001:1.0, curve); set(gca, 'xlim', [0 0.3]); set(gca, 'ylim', [0 1])

xlabel('Geodeisc error')
ylabel('Correspondence Accuracy %')