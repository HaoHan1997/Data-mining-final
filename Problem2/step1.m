%% Final Project - Problem2 - step1.m
% Created by 1352847 Junpeng Ouyang on Jan 6, 2015. All rights reserved.

% In this step we we use the formula bxi = �� + bx + bi 
% and build the baseline estimator over the training data set,
% and to predict the ratings of test data set.

% �� = overall mean rating, already calculated in problem2_init.m.
% bx = rating deviation of user x
%    = (avg. rating of user x) - ��
% bi = (avg. rating of movie i) - ��

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
    
    sim_vec = ii_mat_sim(rating_movie, :);
    
    bx = user_mean_rating(rating_user) - mu;
    bi = movie_mean_rating(rating_movie) - mu;
    bxi = mu + bx + bi;
    
    predict_y(test_index) = bxi;

    % t1_e = clock;
    
    fprintf('Test data #%d: predict %f, real %f, error = %f.\n', test_index, predict_y(test_index), rating_real, predict_y(test_index) - rating_real);
end


%% Root Mean Square Error
rmse = zeros(length(test_data), 2);
for test_index = 1:length(test_data),
    rmse(test_index, 1) = (predict_y(test_index) - test_data(test_index, 3)) ^ 2;
    if test_index == 1,
        rmse(test_index, 2) = rmse(test_index, 1) ^ 0.5;
    else
        rmse(test_index, 2) = (( (rmse(test_index - 1, 2) ^ 2) * (test_index - 1) + rmse(test_index, 1)) / test_index) ^ 0.5;
    end
end

csvwrite('baseline_predict.csv', [predict_y, test_data(:, 3), rmse(:, 1), rmse(:, 2)]);

% parpool close;