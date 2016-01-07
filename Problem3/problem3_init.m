%% Final Project - Problem3 - problem3_init.m
% Created by 1352847 Junpeng Ouyang on Jan 7, 2015. All rights reserved.

%% Read data from csv

train_data = csvread('ratings_train.csv');
train_data = train_data(:, 1:3);
test_data = csvread('ratings_test.csv');
test_data = test_data(:, 1:3);

%% Get the maximum movie id and user id.
% (movie_id_max = 3950, user_id_max = 6040)
movie_col = train_data(:, 2);
user_col = train_data(:, 1);
movie_total = max(movie_col);
user_total = max(user_col);

%% Calculate rank matrix.

% pre-allocate item-item Matrix ii_mat.
uu_mat = zeros(user_total, movie_total);

% item-item Matrix, ii_mat(i, j) = r means user #j rated movie #i
% with rating r. (r = 1, 2, 3, 4, 5; r = 0 means not rated)
for i = 1:length(train_data),
    user_id = train_data(i, 1);
    movie_id = train_data(i, 2);
    rank = train_data(i, 3);
    uu_mat(user_id, movie_id) = rank;
end

%% Save as .mat

save('problem3');
