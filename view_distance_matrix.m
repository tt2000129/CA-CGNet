load('./data/FAUST/resample/distance_maps/tr_reg_095.mat')
%load('.\data\FAUST\6890\tr_reg_095.mat')
trisurf(TRIV,VERT(:,1),VERT(:,2),VERT(:,3),D(1,:)); colorbar; colormap flag; axis equal; shading interp; axis off
hold
scatter3(VERT(1,1),VERT(1,2),VERT(1,3),30,'g','filled');
title('Geodesic Distance from Source Point','FontSize',28)
