%% Start init

clear all;
load('ii_mat');

train_data_with_time = csvread('ratings_train_with_time.csv');
test_data_with_time = csvread('ratings_test_with_time.csv');

%% Initialize item-bin
bin_size = 12;

movie_bin = zeros(movie_total, bin_size);
movie_bin_size = zeros(movie_total, bin_size);

movie_rating_bin_train = [train_data_with_time(:, 2), train_data_with_time(:, 3), train_data_with_time(:, 8)];

for i = 1:movie_total,
    movie_id = movie_rating_bin_train(i, 1);
    movie_rating = movie_rating_bin_train(i, 2);
    bin = movie_rating_bin_train(i, 3);

    movie_bin(movie_id, bin) = (movie_bin(movie_id, bin) * movie_bin_size(movie_id, bin)) + movie_rating;
    movie_bin(movie_id, bin) = movie_bin(movie_id, bin) / (movie_bin_size(movie_id, bin) + 1);
    movie_bin_size(movie_id, bin) = movie_bin_size(movie_id) + 1;
end

for i = 1:movie_total,
    for j = 1:bin_size,
        if movie_bin(i, j) ~= 0,
            movie_bin(i, j) = movie_bin(i, j) - movie_mean_rating(i);
        end
    end
end

%% Init user mean rating time
beta = 0.4;

user_rating_time_mean = zeros(user_total, 1);
user_rating_count = zeros(user_total, 1);

for i = 1:movie_total,
    user_id = train_data_with_time(i, 1);
    user_rating_time = train_data_with_time(i, 8);
    
    user_rating_time_mean(user_id) = user_rating_time_mean(user_id) + user_rating_time;
    user_rating_count(user_id) = user_rating_count(user_id) + 1;
end

for i = 1:user_total,
    user_rating_time_mean(i) = user_rating_time_mean(i) / user_rating_count(i);
end

%% Init user medium rating

user_median_rating = zeros(user_total, 1);
for u = 1:user_total,
    user_ratings = ii_mat(:, u);
    user_ratings = user_ratings(user_ratings ~= 0);
    user_median_rating(u) = median(user_ratings);
end

%% Save

save('step3');