clear all; close all; clc

addpath(genpath('./'))
addpath(genpath('./../Tools/'))

%% Calculate inter pairs
% test_idx=[80:99];
% pairs_list = [];
% for i=1:20
%     for j = 1:20
%         pairs_list = [pairs_list; test_idx(i),test_idx(j)];
%     end
% end
% 
% delete_idx = floor(pairs_list(:,1)/10) == floor(pairs_list(:,2)/10);
% pairs_list(delete_idx,:)=[];
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
CURVES = zeros(N_pairs,1001);
for i=1:N_pairs
    %here you calculate matches, gt_matches and D_model, for each pair
    source_id = sprintf('%03d', pairs_list(i,1));
    target_id = sprintf('%03d', pairs_list(i,2));
    
%      mesh_0 = load(['./data/FAUST/resample/tr_reg_',source_id]); %Choose the indices of the test pair
%      mesh_1 = load(['./data/FAUST/resample/tr_reg_',target_id]); %Choose the indices of the test pair
     
%      source = source_id(2:end);
%      target = target_id(2:end);

%      X = load(['./SURFMNet/faust_matches/resample/tr_reg_',source_id,'-tr_reg_',target_id,'.mat']); %Choose the indices of the test pair
     X = load(['./MGCN/faust_matches/F4096/',source_id,'_',target_id,'.mat']); %Choose the indices of the test pair
%      matches = X.softCorr;
%      X = load(['./FM_PMF/faust_matches/6890/inter/matches_',source_id,target_id,'.mat']); %Choose the indices of the test pair
     matches = X.matches;
%     [~, matches] = max(squeeze(X.softCorr),[],1);

    D_model = load(['./data/FAUST/resample/distance_maps/tr_reg_',target_id]); %Choose the indices of the test pair
    D_model = D_model.D;

    gt_matches = 1:4096;

    %here you calculate the error curves and average them
    errs = calc_geo_err(matches, gt_matches, D_model);
    mean_ge(i,1) = mean(errs);
    curve = calc_err_curve(errs, 0:0.001:1.0)/100;
    CURVES(i,:) = curve;
end
ave_ge = mean(mean_ge)
mean_ge_ou = mean_ge(2:2:end,:);
ave_ge_ou = mean(mean_ge_ou) %Å¼ÊýÐÐ
% save('./SORCNet/faust_matches/inter_ave_ge_6890.mat','ave_ge');
avg_curve = sum(CURVES,1)/ N_pairs;
save('./MGCN/faust_matches/inter_ge_curve_4096.mat','avg_curve');
% plot(0:0.001:1.0, avg_curve,'r'); set(gca, 'xlim', [0 0.1]); set(gca, 'ylim', [0 1])
% 
% % plot(0:0.001:1.0, curve); set(gca, 'xlim', [0 0.1]); set(gca, 'ylim', [0 1])
% 
% xlabel('Geodesic error')
% ylabel('Correspondence Accuracy %')
% 
% title('Geodesic error - all inter pairs')