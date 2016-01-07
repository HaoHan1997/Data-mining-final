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


%% Calculate rank matrix.

% pre-allocate item-item Matrix ii_mat.
ii_mat = zeros(movie_id_max, user_id_max);

% item-item Matrix, ii_mat(i, j) = r means user #j rated movie #i
% with rating r. (r = 1, 2, 3, 4, 5; r = 0 means not rated)
for i = 1:length(train_data),
    user_id = train_data(i, 1);
    movie_id = train_data(i, 2);
    rank = train_data(i, 3);
    ii_mat(movie_id, user_id) = rank;
end

%% Calculate overall mean ratings (mu).
mu = 0;
for i = 1:length(train_data),
    mu = mu + train_data(i, 3);
end
mu = mu / length(train_data);

%% Calculate normalized ratings
normalize_ii_mat = ii_mat;
ii_mat_size = size(ii_mat);
movie_total = ii_mat_size(1);
user_total = ii_mat_size(2);

for i = 1:size(movie_total),
    normalize_ii_mat(i, :) = normalize_row(ii_mat(i, :));
end

%% Calculate mean user rank, mean movie rank

user_mean_rating = zeros(user_total, 1);
movie_mean_rating = zeros(movie_total, 1);

for i = 1:user_total,
    user_rated_vec = ii_mat(:, i);
    user_rated_vec = user_rated_vec(user_rated_vec ~= 0);
    user_mean_rating(i) = mean(user_rated_vec);
end

for i = 1:movie_total,
    movie_rated_vec = ii_mat(i, :)';
    movie_rated_vec = movie_rated_vec(movie_rated_vec ~= 0);
    movie_mean_rating(i) = mean(movie_rated_vec);
    if (isnan(movie_mean_rating(i))),
        movie_mean_rating(i) = 0;
    end
end

%% Calculate simulate vector for each movie vs other movies

% ii_mat_sim(i, j) = sim means movie#i and movie#j have pearson similarity
% values sim. (After normalized)
ii_mat_sim = zeros(movie_total, movie_total);

for i = 1:(movie_total - 1),
    ii_mat_sim(i, i) = 1.0;
    for j = (i + 1):movie_total,
        tic
        movie_i = normalize_ii_mat(i, :);
        movie_j = normalize_ii_mat(j, :);
        sim = pearson_sim(movie_i, movie_j);
        ii_mat_sim(i, j) = sim;
        ii_mat_sim(j, i) = sim;
        toc
    end
end
ii_mat_sim(movie_total, movie_total) = 1.0;


%% Export as .mat compressed buffer
save('ii_mat');

