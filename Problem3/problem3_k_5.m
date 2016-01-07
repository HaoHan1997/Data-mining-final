%% Final Project - Problem3 - problem3_k_5.m
% Created by 1352847 Junpeng Ouyang on Jan 7, 2015. All rights reserved.

%% Load from .mat
load('problem3.mat');
K = 5;

%% Get index from build-in k-means function

tic
[indices, centroid] = kmeans(uu_mat, K);
toc

%% Calculate centroid of each tag k

% points_total = zeros(K, 1);

% for i = 1:length(indices),
%    k = indices(i);
%    points_total(k) = points_total(k) + 1;
%    centroid(k, :) = centroid(k, :) + uu_mat(i, :);
%end

%for k = 1:K,
%    centroid(k, :) = centroid(k, :) ./ points_total(k);
%end

