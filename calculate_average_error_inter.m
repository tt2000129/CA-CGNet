clear all; close all; clc

addpath(genpath('./'))
addpath('./computeLaplacian');
%% Calculate intra pairs
pairs_list = [];
temp = 1;
for i=80:99
    for j = i:99
        if fix(i/10)~=fix(j/10)
            pairs_list(temp,1) = i;
            pairs_list(temp,2) = j;
            temp = temp + 1;
        end
    end
end

%% Calculate geodesic curve
N_pairs = size(pairs_list,1);
aveerrs = zeros(N_pairs,1);
for i=1:N_pairs
    %here you calculate matches, gt_matches and D_model, for each pair
    source_id = sprintf('%03d', pairs_list(i,1));
    target_id = sprintf('%03d', pairs_list(i,2));
    
    % mesh_0 = load(['./data/FAUST/resample/tr_reg_',source_id]); %Choose the indices of the test pair
    % mesh_1 = load(['./data/FAUST/resample/tr_reg_',target_id]); %Choose the indices of the test pair

%     X = load(['./SURFMNet/faust_matches/6890/','tr_reg_',source_id,'-tr_reg_',target_id,'.mat']); %Choose the indices of the test pair
    X = load(['./MGCN/faust_matches/F4096/',source_id,'_',target_id,'.mat']); %Choose the indices of the test pair
%     X = load(['./FM_PMF/faust_matches/6890/inter/matches_',source_id,target_id,'.mat']); %Choose the indices of the test pair
    matches = X.matches;
    
    D_model = load(['./data/FAUST/resample/distance_maps/tr_reg_',target_id]); %Choose the indices of the test pair
    D_model = D_model.D;

    gt_matches = 1:4096;
    aveerrs(i) = calc_ave_err(matches, gt_matches, D_model);
end
ave_inter = mean(aveerrs)