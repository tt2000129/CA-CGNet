clear all; close all; clc

addpath(genpath('./'))

%% load test pairs
fid = fopen('./data/KIDS/testKIDS.txt', 'rt');
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

%% Calculate geodesic curve
N_pairs = size(pairs_list,1);
CURVES = zeros(N_pairs,1001);
mean_ge = [];
count = 1;
% for i=1:N_pairs
for i=1:3 %1,3,69,259,287,323,344,359,414
    %here you calculate matches, gt_matches and D_model, for each pair
    source_id = sprintf('%s', pairs_list{i,1});
    target_id = sprintf('%s', pairs_list{i,2});
    
%     mesh_0 = load(['./data/TOSCA/4096/',source_id]); %Choose the indices of the test pair
%     mesh_1 = load(['./data/TOSCA/4096/',target_id]); %Choose the indices of the test pair
%     if isletter(source_id(end-2:end-1))
%         source_mid = [source_id(1:end-1),'0',source_id(end:end)];
%     else
%         source_mid = source_id;
%     end
%     if isletter(target_id(end-2:end-1))
%         target_mid = [target_id(1:end-1),'0',target_id(end:end)];
%     else
%         target_mid = target_id;
%     end
%     source_mid = [source_id(1:4),source_id(end-1:end)];
%     target_mid = [target_id(1:4),target_id(end-1:end)];
%     X = load(['./SURFMNet/kids_matches/resample/',source_mid,'-',target_mid,'.mat']); 
    X = load(['./MGCN/KIDS/4096/',source_id,'_',target_id,'.mat']); %Choose the indices of the test pair
%     matches = X.softCorr; %FMnet
    matches = X.matches;
    %     [~, matches] = max(squeeze(X.softCorr),[],1);

    D_model = load(['./data/KIDS/resample/distance_maps/',target_id]);  %Choose the indices of the test pair
    D_model = D_model.D;

    gt_matches = 1:4096;

    %here you calculate the error curves and average them
    errs = calc_geo_err(matches, gt_matches, D_model);
    mean_ge(count,1) = mean(errs);
    count = count+1;
    curve = calc_err_curve(errs, 0:0.001:1.0)/100;
    CURVES(i,:) = curve;
end
mean_ge_ou = mean_ge(2:2:end,:);
ave_ge_ou = mean(mean_ge_ou) %Å¼ÊýÐÐ
ave_ge = mean(mean_ge)
% save('./SORCNet_new/tosca_matches/ave_ge.mat','ave_ge');
% CURVES_ou = CURVES(2:2:end,:);
% avg_curve = sum(CURVES_ou,1)/ N_pairs * 2;
% % avg_curve = CURVES(11,:);
% save('./SORCNet_new/kids_matches/ge_curve.mat','avg_curve');
% plot(0:0.001:1.0, avg_curve,'r'); set(gca, 'xlim', [0 0.3]); set(gca, 'ylim', [0 1])
% 
% plot(0:0.001:1.0, curve); set(gca, 'xlim', [0 0.3]); set(gca, 'ylim', [0 1])
% 
% xlabel('Geodesic error')
% ylabel('Correspondence Accuracy %')
% 
% title('Geodesic error - all TOSCA pairs')