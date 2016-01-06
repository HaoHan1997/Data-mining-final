%% Final Project - Problem2 - step1.m
% Created by 1352847 Junpeng Ouyang on Jan 6, 2015. All rights reserved.

% In this step we we use the formula bxi = ¦Ì + bx + bi 
% and build the baseline estimator over the training data set,
% and to predict the ratings of test data set.

% ¦Ì = overall mean rating, already calculated in problem2_init.m.
% bx = rating deviation of user x
%    = (avg. rating of user x) ? ¦Ì
% bi = (avg. rating of movie i) ? ¦Ì

%% We read data buffer from problem2_init spawned

load('ii_mat.mat');

% parpool local 4;

%% Demo predict rows in test_data
predict_y = zeros(length(test_data), 1);
for test_index = 1:length(test_data),
    rating_user = test_data(test_index, 1);
    rating_movie = test_data(test_index, 2);
    rating_real = test_data(test_index, 3);

    sim_vec = zeros(movie_total, 1);
    norm_movie_row = normalize_ii_mat(rating_movie, :);

    for i = 1:movie_total,
        if i == rating_movie,
            sim_vec(i) = 1.0;
            continue;
        end
        sim_vec(i) = pearson_sim(norm_movie_row, normalize_ii_mat(i, :));
    end

    rxi = estimate_rating(sim_vec', ii_mat(:, rating_user)', rating_movie);
    
    bxi = mu + (user_mean_rating(rating_user) - mu) + (movie_mean_rating(rating_movie) - mu);
    
    predict_y(test_index) = bxi + rxi;

    fprintf('Test data #%d: predict %f, real %f.\n', test_index, predict_y(test_index), rating_real);
end

% parpool close;