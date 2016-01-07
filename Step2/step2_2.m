%% Final Project - Problem2 - step2_2.m
% Created by 1352847 Junpeng Ouyang on Jan 7, 2015. All rights reserved.

% Following the Page 31 of lect-recom.pdf, we use the neighborhood approach to
% j¡ÊN(i;x) Sij?(rij?bxj) predict the rating score, i.e., using the formula rxi = bxi + ¡Æ Sij .
% j ¡Ê N(i;x) As for the weight wij, we respectively use two different schemes.

%% Load init

load('step2');

%% User based similarity

predict_y = zeros(length(test_data), 1);
for test_index = 1:length(test_data),
    rating_user = test_data(test_index, 1);
    rating_movie = test_data(test_index, 2);
    rating_real = test_data(test_index, 3);
    
    norm_user_row = normalize_uu_mat(rating_user, :);
    
    sim_vec = uu_mat_sim(rating_user, :);
    
    [sorted_sim_vec, sort_index] = sort(sim_vec);
    sorted_sim_vec = fliplr(sorted_sim_vec);
    sort_index = fliplr(sort_index);
    
    neighbour_sim_vec = sorted_sim_vec(1:1+K);
    neighbour_index = sort_index(1:1+K);
    neighbour_ratings = zeros(K + 1, 1);
    for k = 1:K + 1,
        neighbour_ratings(k, 1) = uu_mat(neighbour_index(k), rating_movie);
    end
    
    bi = user_mean_rating(rating_user) - mu;
    bx = movie_mean_rating(rating_movie) - mu;
    bxi = mu + bx + bi;
    
    bxj_vec = zeros(21, 1);
    for k = 1:K + 1,
        bxj_vec(k) = user_mean_rating(neighbour_index(k));
    end
    bxj_vec = bxj_vec - mu;
    rxi = estimate_rating_baseline(neighbour_sim_vec', neighbour_ratings, 1, mu, bx, bxj_vec);
    
    predict_y(test_index) = bxi + rxi;
    
    fprintf('Test data #%d: predict %f, real %f, error = %f.\n', test_index, predict_y(test_index), rating_real, predict_y(test_index) - rating_real);
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

csvwrite('neighbour_predict_2.csv', [predict_y, test_data(:, 3), rmse(:, 1), rmse(:, 2)]);
