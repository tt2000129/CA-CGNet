clear all; close all; clc

addpath(genpath('./'))
addpath('./computeLaplacian');
%% load test pairs
fid = fopen('./data/SCAPE/testSCAPE.txt', 'rt');
f = textscan(fid, '%s');
fclose(fid); 
test_pairs = f{1,1};
for i = 1:size(test_pairs)
    if mod(i,2)~=0
        pairs_list((i+1)/2,1) = test_pairs(i,1);
    else
        pairs_list(i/2,2) = test_pairs(i,1);
    end
end

%% Calculate average error
N_pairs = size(pairs_list,1);
aveerrs = zeros(N_pairs,1);
for i=1:N_pairs
    %here you calculate matches, gt_matches and D_model, for each pair
    source_id = sprintf('%s', pairs_list{i,1});
    target_id = sprintf('%s', pairs_list{i,2});
    
%     mesh_0 = load(['./data/TOSCA/resample/',source_id]); %Choose the indices of the test pair
%     mesh_1 = load(['./data/TOSCA/resample/',target_id]); %Choose the indices of the test pair

    X = load(['./MGCN/SCAPE/4096/',source_id,'_',target_id,'.mat']); %Choose the indices of the test pair
%     X = load(['./FM_PMF/faust_matches/6890/intra/matches_',source_id,target_id,'.mat']); %Choose the indices of the test pair
%     matches = X.matches_filter;
    matches = X.matches;
    
    D_model = load(['./data/SCAPE/resample/distance_maps/',target_id]); %Choose the indices of the test pair
    D_model = D_model.D;

    gt_matches = 1:4096;
    aveerrs(i) = calc_ave_err(matches, gt_matches, D_model);
end
ave_e = mean(aveerrs)
[sort_aveerrs,id] = sort(aveerrs);
for j=1:size(id,1)
    pairs{j,1} = pairs_list{id(j,1),1};
    pairs{j,2} = pairs_list{id(j,1),2};
end
save('./MGCN/SCAPE/sort_aveerrs.mat','sort_aveerrs','pairs');