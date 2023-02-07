clear all; close all; clc

addpath(genpath('./'))

%% Calculate intra pairs
% test_idx=[80:99];
% pairs_list = [];
% for i=1:20
%     for j = 1:20
%         pairs_list = [pairs_list; test_idx(i),test_idx(j)];
%     end
% end
% 
% delete_idx = floor(pairs_list(:,1)/10) ~= floor(pairs_list(:,2)/10);
% pairs_list(delete_idx,:)=[];
% pairs_list = [];
% temp = 1;
% for i=80:99
%     for j = i:99
%         if fix(i/10)==fix(j/10)
%             pairs_list(temp,1) = i;
%             pairs_list(temp,2) = j;
%             temp = temp + 1;
%         end
%     end
% end

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
% fid = fopen('./data/SCAPE/testSCAPE.txt', 'rt');
% f = textscan(fid, '%s');
% fclose(fid); 
% test_pairs = f{1,1};
% temp = 1;
% for i = 1:size(test_pairs)
% %     str = test_pairs{i,1}(1:2);
% %     if strcmp(str,'wo')
%         if mod(i,2)~=0
%             pairs_list(temp,1) = test_pairs(i,1);
%         else
%             pairs_list(temp,2) = test_pairs(i,1);
%             temp = temp+1;
%         end
% %     end
% end

% pairs_list = [];
% temp = 1;
% for i = 80:99
%     pairs_list(temp,1) = i;
%     pairs_list(temp,2) = 80;
%     temp = temp + 1;
% end
%% Calculate geodesic curve
N_pairs = size(pairs_list,1);
% CURVES = zeros(N_pairs,1001);
for i=1:N_pairs
    %here you calculate matches, gt_matches and D_model, for each pair
    source_id = sprintf('%03d', pairs_list(i,1));
    target_id = sprintf('%03d', pairs_list(i,2));
    
    mesh_0 = load_off(['./data/FAUST/4096/tr_reg_',source_id, '.off']); %Choose the indices of the test pair
    mesh_1 = load_off(['./data/FAUST/4096/tr_reg_',target_id, '.off']); %Choose the indices of the test pair
%     source_id = sprintf('%s', pairs_list{i,1});
%     target_id = sprintf('%s', pairs_list{i,2});
%     mesh_0 = load(['./data/FAUST/4096/',source_id]); %Choose the indices of the test pair
%     mesh_1 = load(['./data/FAUST/4096/',target_id]); %Choose the indices of the test pair
%     source = source_id(2:end);
%     target = target_id(2:end);
%     X = load(['./FM_PMF/faust_matches/4096/intra/matches_',source_id,target_id,'.mat']); %Choose the indices of the test pair
    X = load(['./ORCFMnet/faust_matches/4096/',source_id,'_',target_id,'.mat']); %Choose the indices of the test pair
    matches = X.matches; %FMnet randomforests
%     X = load(['./capsFMnet/faust_matches/6890/intra/',source_id,'_',target_id,'.mat']); 
%     matches = X.matches;

    D_model = load(['./data/FAUST/4096/distance_maps/tr_reg_',target_id]); %Choose the indices of the test pair
%     D_model = load(['./data/FAUST/4096/distance_maps/',target_id]);  %Choose the indices of the test pair
    D_model = D_model.D;

    gt_matches = 1:4096;

    %here you calculate the error curves and average them
    errs = calc_geo_err(matches, gt_matches, D_model);
    mean_ge(i,1) = mean(errs);
%     cVals = (0:0.00001:0.2)';
%     cMap = colormap(hot);
%     cmap = flipud(cMap);
%     lin = linspace(0,0.2,size(cmap,1));
%     fColsDbl = interp1(lin,cmap,cVals);
% 
%     finalColor=[];
%     for IterRecord=1:6890
%         temp = roundn(double(errs(IterRecord,1)),-5);
%         for i=1:size(cVals,1)
%             cv = cVals(i,1);
%             if any(abs(cv-temp)<1e-6)
%                 break;
%             end
%         end
%         if i>size(cVals,1)
%             fprintf('not found!');
%         end
%         finalColor(IterRecord,:)=fColsDbl(i,:);
%     end
%     figure;
%     subplot_tight(1,2,2); colormap(finalColor);
%     plot_scalar_map(mesh_0,[1: size(mesh_0.VERT,1)]');freeze_colors;title('Source'); axis off;
end
% [sort_ge,id] = sort(mean_ge);
% for j=1:size(id,1)
%     pairs{j,1} = pairs_list{id(j,1),1};
%     pairs{j,2} = pairs_list{id(j,1),2};
% end
mean_ge_intra = mean(mean_ge)
best_ge_intra = min(mean_ge)