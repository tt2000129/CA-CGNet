clear all; close all; clc
%% data params
X = load(['./ORCFMnet/scape_matches/4096/mesh001_mesh002','.mat']); 
%     matches = X.softCorr; %FMnet
matches = X.matches;
%     [~, matches] = max(squeeze(X.softCorr),[],1);

D_model = load('./data/SCAPE/4096/distance_maps/mesh002');  %Choose the indices of the test pair
D_model = D_model.D;

gt_matches = 1:4096;

%here you calculate the error curves and average them
errs = calc_geo_err(matches, gt_matches, D_model);
curve = calc_err_curve(errs, 0:0.001:1.0)/100;

save('./ORCFMnet/scape_matches/curve_mesh001_mesh002.mat','curve');
