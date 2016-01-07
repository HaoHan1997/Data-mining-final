%% Load init

load('step3');
K = 20;

%% Predict (3)

predict_y = zeros(length(test_data_with_time), 1);

for test_index = 1:length(test_data_with_time),
    % t1_s = clock;
    rating_user = test_data_with_time(test_index, 1);
    rating_movie = test_data_with_time(test_index, 2);
    rating_real = test_data_with_time(test_index, 3);
    rating_time = test_data_with_time(test_index, 8);

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
    
    % We improve this in step 3, adding alpha * dev
    if rating_time > user_rating_time_mean(user_id),
        dev = abs(rating_time - user_rating_time_mean(user_id)) ^ beta;
    else
        dev = (-1.0) * (abs(rating_time - user_rating_time_mean(user_id)) ^ beta);
    end
    
    if user_median_rating(user_id) > user_mean_rating(user_id),
        alpha = user_mean_rating(user_id) / user_median_rating(user_id);
    else
        alpha = user_median_rating(user_id) / user_mean_rating(user_id);
    end
    
    bx = user_mean_rating(rating_user) - mu + (alpha * dev);
    
    % We improve this in step 3, adding b(i, Bin(t))
    bi = movie_mean_rating(rating_movie) - mu + movie_bin(rating_movie, rating_time);
    bxi = mu + bx + bi;
    
    bxj_vec = zeros(21, 1);
    for k = 1:K + 1,
        bxj_vec(k) = movie_mean_rating(neighbour_index(k)) + movie_bin(k, rating_time);
    end
    bxj_vec = bxj_vec - mu;
    rxi = estimate_rating_baseline(neighbour_sim_vec', neighbour_ratings, 1, mu, bx, bxj_vec);
    
    predict_y(test_index) = bxi + rxi;
    if predict_y(test_index) < 1,
        predict_y(test_index) = 1;
    elseif predict_y(test_index) > 5,
        predict_y(test_index) = 5;
    end
        
    
    % t1_e = clock;
   
    %fprintf('Test data #%d: predict %f, real %f. Simvec Use time: %f, total time: %f.\n', test_index, predict_y(test_index), rating_real, etime(t2_e, t2_s), etime(t1_e, t1_s));
    fprintf('Test data #%d: predict %f, real %f, error = %f.\n', test_index, predict_y(test_index), rating_real, predict_y(test_index) - rating_real);
end

% csvwrite('neighbour_predict_1.csv', [predict_y, test_data(:, 3)]);

%% Root Mean Square Error
rmse = zeros(length(test_data), 2);
for test_index = 1:length(test_data),
    rmse(test_index, 1) = (predict_y(test_index) - test_data(test_index, 3)) ^ 2;
    if test_index == 1,
        rmse(test_index, 2) = rmse(test_index, 1) ^ 0.5;
    else
        rmse(test_index, 2) = (rmse(test_index - 1, 2) ^ 2 + rmse(test_index, 1)) ^ 0.5;
    end
end

csvwrite('incorporating_temporal_dynamics_predict.csv', [predict_y, test_data(:, 3), rmse(:, 1), rmse(:, 2)]);


% parpool close;