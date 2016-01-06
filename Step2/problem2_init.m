%% Final Project - Problem2 - problem2_init.m
% Created by 1352847 Junpeng Ouyang on Jan 6, 2015. All rights reserved.

%% First we read train and test csv files.

train_data = csvread('./ratings_train.csv');
train_data = train_data(:, 1:3);
test_data = csvread('./ratings_test.csv');
test_data = test_data(:, 1:3);

%% We find out the maximum movie id and user id.
% (movie_id_max = 395, user_id_max = 6040)
movie_col = train_data(:, 2);
user_col = train_data(:, 1);
movie_id_max = max(movie_col);
user_id_max = max(user_col);


%% Pre-allocate rank matrix.
% item-item Matrix, ii_mat(i, j) = r means user #j rated movie #i
% with rating r. (r = 1, 2, 3, 4, 5; r = 0 means not rated)
ii_mat = zeros(movie_id_max, user_id_max);
for i = 1:length(train_data),
    user_id = train_data(i, 1);
    movie_id = train_data(i, 2);
    rank = train_data(i, 3);
    ii_mat(movie_id, user_id) = rank;
end

%% Export as .mat
save('ii_mat');
