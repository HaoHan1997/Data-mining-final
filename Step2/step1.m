%% Final Project - Problem2 - step1.m
% Created by 1352847 Junpeng Ouyang on Jan 6, 2015. All rights reserved.

% In this step we we use the formula bxi = ¦Ì + bx + bi 
% and build the baseline estimator over the training data set,
% and to predict the ratings of test data set.

% ¦Ì = overall mean rating, already calculated in problem2_init.m.
% bx = rating deviation of user x
%    = (avg. rating of user x) - ¦Ì
% bi = (avg. rating of movie i) - ¦Ì

%% We read data buffer from problem2_init spawned

load('ii_mat.mat');

% parpool local 4;

%% Demo predict rows in test_data
predict_y = zeros(length(test_data), 1);
for test_index = 1:length(test_data),
    % t1_s = clock;
    rating_user = test_data(test_index, 1);
    rating_movie = test_data(test_index, 2);
    rating_real = test_data(test_index, 3);

    norm_movie_row = normalize_ii_mat(rating_movie, :);
    
    % This code takes 99% of the time in per loop. Need optimize.
    % t2_s = clock;
    %for i = 1:movie_total,
    %    if i == rating_movie,
    %        sim_vec(i) = 1.0;
    %        continue;
    %    end
    %    sim_vec(i) = pearson_sim(norm_movie_row, normalize_ii_mat(i, :));
    %end
    % t2_e = clock;
    sim_vec = ii_mat_sim(rating_movie, :);
    
    bx = user_mean_rating(rating_user) - mu;
    bi = movie_mean_rating(rating_movie) - mu;
    bxi = mu + bx + bi;
    
    predict_y(test_index) = bxi;

    % t1_e = clock;
   
    %fprintf('Test data #%d: predict %f, real %f. Simvec Use time: %f, total time: %f.\n', test_index, predict_y(test_index), rating_real, etime(t2_e, t2_s), etime(t1_e, t1_s));
    fprintf('Test data #%d: predict %f, real %f.\n', test_index, predict_y(test_index), rating_real);
end


%% Root Mean Square Error
rmse = zeros(length(test_data), 2);
for test_index = 1:length(test_data),
    rmse(test_index, 1) = ((predict_y(test_index) - test_data(test_index, 3)) ^ 2) ^ 0.5;
    if test_index == 1,
        rmse(test_index, 2) = rmse(test_index, 1);
    else
        rmse(test_index, 2) = rmse(test_index - 1, 2) + rmse(test_index, 1);
    end
end

csvwrite('baseline_predict.csv', [predict_y, test_data(:, 3), rmse(:, 1), rmse(:, 2)]);

% parpool close;