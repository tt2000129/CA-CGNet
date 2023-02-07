clear all; close all; clc

x = [0:0.001:1.0];

% ORCFM_curve = load('./ORCFMnet/faust_matches/curve_mesh000_mesh046.mat'); 
% ORCFM_curve = ORCFM_curve.avg_curve*100;
% ORCFM_curve = ORCFM_curve.curve*100;
% SORC_curve_new = load('./SORCNet_new/faust_matches/intra_ge_curve_6890.mat'); 
% SORC_curve_new = SORC_curve_new.avg_curve*100;

% SORCdec_curve = load('./SORCNet_dec/faust_matches/intra_ge_curve_6890.mat'); 
% SORCdec_curve = SORCdec_curve.avg_curve*100;

% SORC_curve = load('./SORCNet/faust_matches/intra_ge_curve_6890new.mat'); 
% SORC_curve = SORC_curve.avg_curve*100;

% caps_curve = load('./capsFMnet/faust_matches/intra_ge_curve_6890.mat'); 
% caps_curve = caps_curve.avg_curve*100;

FAUST6890_curve = load('./MGCN/faust_matches/intra_ge_curve_6890.mat'); 
% FM_curve = FM_curve.avg_curve*100;
FAUST6890_curve = FAUST6890_curve.avg_curve;

FAUST4096_curve = load('./MGCN/faust_matches/intra_ge_curve_4096.mat'); 
% FM_curve = FM_curve.avg_curve*100;
FAUST4096_curve = FAUST4096_curve.avg_curve;

linw = 2;
plot(x , FAUST6890_curve, 'g', 'linewidth',linw);hold on;
plot(x , FAUST4096_curve, 'b', 'linewidth',linw);hold on;
legend('6890','4096');
set(gca, 'xlim', [0 0.3]); 
set(gca, 'ylim', [0 1]);
grid on;

xlabel('Geodesic error')
ylabel('Correspondence Accuracy %')

% unsupervisedFM_curve = load('./unsupervised_FMnet/faust_matches/resample_085_088.mat'); 
% % unsupervisedFM_curve = unsupervisedFM_curve.avg_curve*100;
% unsupervisedFM_curve = unsupervisedFM_curve.curve*100;
% 
% rf_curve = load('./randomforests/faust_matches/resample_085_088.mat'); 
% % rf_curve = rf_curve.avg_curve*100;
% rf_curve = rf_curve.curve*100;
%                                                                                                                     
% SURFM_curve = load('./SURFMNet/faust_matches/resample_085_088.mat'); 
% % SURFM_curve = SURFM_curve.avg_curve*100;
% SURFM_curve = SURFM_curve.curve*100;
% 
% linw = 4;
% plot(x , rf_curve, 'c', 'linewidth',linw);hold on;
% plot(x , unsupervisedFM_curve, 'y', 'linewidth',linw);hold on;
% plot(x , FAUST_curve, 'k', 'linewidth',linw);hold on;   %黑色，指定线宽
% plot(x , SURFM_curve, 'b', 'linewidth',linw);hold on;
% % plot(x , SORCdec_curve, 'g', 'linewidth',linw);hold on;
% % plot(x , caps_curve, 'g', 'linewidth',linw);hold on;
% % % plot(x , SORC_curve, 'r', 'linewidth',linw);hold on; 
% % plot(x , SORC_curve_new, 'r', 'linewidth',linw);hold on;
% % legend('RF','Halimi el.','FMNet','SURFMNet','Ours without OptResBlock','Ours'); %'Ours without OptResBlock'
% legend('RF','Unsupervised FMNet','FMNet', 'SURFMNet');
% set(gca, 'xlim', [0 0.4]); 
% set(gca, 'ylim', [0 100]);
% grid on;
% 
% xlabel('Geodesic error')
% ylabel('Correspondence Accuracy %')
