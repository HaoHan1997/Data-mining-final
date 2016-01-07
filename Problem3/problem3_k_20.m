%% Final Project - Problem3 - problem3_k_20.m
% Created by 1352847 Junpeng Ouyang on Jan 7, 2015. All rights reserved.

%% Load from .mat
load('problem3.mat');
K = 20;

%% Get index from build-in k-means function

tic
[indices, centroid] = kmeans(uu_mat, K);
toc

%% Save results

save('K20');
