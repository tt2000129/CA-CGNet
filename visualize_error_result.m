clear all; close all; clc
addpath(genpath('./Utils/'));
addpath('./MatlabRenderToolbox-master/func_render/')
addpath('./MatlabRenderToolbox-master/func_other/')

mesh_dir = './data/FAUST/6890/';
%mesh_dir = '../data/KIDS/resample/';
%mesh_dir = '../data/SCAPE/resample/';
%mesh_dir = '../data/TOSCA/resample/';

s1_name = 'tr_reg_083.off';
s2_name = 'tr_reg_080.off';

% s1_name = '1_00.off';
% s2_name = '1_02.off';

% s1_name = 'mesh000.off';
% s2_name = 'mesh001.off';

% s1_name = 'michael5.off';
% s2_name = 'michael10.off';

S1 = MESH_IO.read_shape([mesh_dir, s1_name]);
S2 = MESH_IO.read_shape([mesh_dir, s2_name]);

mesh_0 = load_off([mesh_dir, s1_name]); %Choose the indices of the test pair
mesh_1 = load_off([mesh_dir, s1_name]);

%X = load(['./data/SGCCResults/FAUST/6890/080_099','.mat']); %Choose the indices of the test pair ORCFMnet
X = load(['./data/DeepFunctionalMap_Results/faust_matches/6890/080_083','.mat']); 
%X = load(['./MGCN_Results/FAUST/6890/080_081','.mat']); 
 %X = load(['./MGCN/KIDS/4096/1_00_1_02','.mat']);
 %X = load(['./MGCN/SCAPE/4096/mesh000_mesh001','.mat']);
 %X = load(['./MGCN/TOSCA/4096/michael5_michael10','.mat']);

%matches = X.matches; %randomforests ORCFMnet optResCapsFMNet
matches = X.softCorr; %FMnet
D_model = load('./data/FAUST/6890/distance_maps/tr_reg_080'); %Choose the indices of the test pair

%D_model = load('./data/KIDS/resample/distance_maps/1_00');
%D_model = load('./data/SCAPE/resample/distance_maps/mesh000');
%D_model = load('./data/TOSCA/resample/distance_maps/michael5');


D_model = D_model.D;

gt_matches = 1:6890;
%gt_matches = 1:4096;

errs = calc_geo_err(matches, gt_matches, D_model);
cVals = (0:0.00001:0.1)';
cMap = colormap(hot);
cmap = flipud(cMap);
lin = linspace(0,0.1,size(cmap,1));
fColsDbl = interp1(lin,cmap,cVals);

finalColor=[];

for IterRecord=1:6890
%for IterRecord=1:4096
    temp = roundn(double(errs(IterRecord,1)),-5);
    for i=1:size(cVals,1)
        cv = cVals(i,1);
        if any(abs(cv-temp)<1e-6)
            break;
        end
    end
    if i>size(cVals,1)
        fprintf('not found!');
    end
    finalColor(IterRecord,:)=fColsDbl(i,:);
end
% figure;
% colormap(finalColor);
figure(1);
[~,~, S1_new] = render_mesh(S1,'MeshVtxColor',finalColor,...
    'RotationOps',{[-90,0,0],[0,0,30]},...
    'CameraPos',[-10,10],...
    'FaceAlpha',0.9); 
% plot_scalar_map(mesh_0,[1: size(mesh_0.VERT,1)]');freeze_colors; axis off;