%% Final Project - Problem2 - step1.m
% Created by 1352847 Junpeng Ouyang on Jan 6, 2015. All rights reserved.

% Following the Page 31 of lect-recom.pdf, we use the neighborhood approach to
% j¡ÊN(i;x) Sij?(rij?bxj) predict the rating score, i.e., using the formula rxi = bxi + ¡Æ Sij .
% j ¡Ê N(i;x) As for the weight wij, we respectively use two different schemes.

%% Load init

load('step2');

%% Predict (1)

predict_y = zeros(length(test_data), 1);
for test_index = 1:length(test_data),
    % t1_s = clock;
    rating_user = test_data(test_index, 1);
    rating_movie = test_data(test_index, 2);
    rating_real = test_data(test_index, 3);

    norm_movie_row = normalize_ii_mat(rating_movie, :);
    
    sim_vec = ii_mat_sim(rating_movie, :);
    
    [sorted_sim_vec, sort_index] = sort(sim_vec);
    sorted_sim_vec = fliplr(sorted_sim_vec);
    sort_index = fliplr(sort_index);
    % neighbour_sim_vec(1) is itself.
    neighbour_sim_vec = sorted_sim_vec(1:1+K);
    neighbour_index = sort_index(1:1+K);
    neighbour_ratings = zeros(K + 1, 1);
    for k = 1:K + 1,
        neighbour_ratings(k, 1) = ii_mat(neighbour_index(k), rating_user);
    end
    
    bx = user_mean_rating(rating_user) - mu;
    bi = movie_mean_rating(rating_movie) - mu;
    bxi = mu + bx + bi;
    
    bxj_vec = zeros(21, 1);
    for k = 1:K + 1,
        bxj_vec(k) = movie_mean_rating(neighbour_index(k));
    end
    bxj_vec = bxj_vec - mu;
    rxi = estimate_rating_baseline(neighbour_sim_vec', neighbour_ratings, 1, mu, bx, bxj_vec);
    
    predict_y(test_index) = bxi + rxi;

    % t1_e = clock;
   
    %fprintf('Test data #%d: predict %f, real %f. Simvec Use time: %f, total time: %f.\n', test_index, predict_y(test_index), rating_real, etime(t2_e, t2_s), etime(t1_e, t1_s));
    fprintf('Test data #%d: predict %f, real %f, error = %f.\n', test_index, predict_y(test_index), rating_real, predict_y(test_index) - rating_real);
end

% csvwrite('neighbour_predict_1.csv', [predict_y, test_data(:, 3)]);

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

csvwrite('neighbour_predict_1.csv', [predict_y, test_data(:, 3), rmse(:, 1), rmse(:, 2)]);


% parpool close;