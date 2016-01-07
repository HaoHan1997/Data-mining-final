function [ r ] = estimate_rating_baseline( sim_col_x, rating_vec, I, mu, bx, bxj_vec )
%ESTIMATE_RATING_BASELINE Summary of this function goes here
%   Detailed explanation goes here
    assert(length(rating_vec) == length(bxj_vec));
    rating_vec_new = zeros(length(rating_vec), 1);
    for i = 1:length(rating_vec),
        if rating_vec(i) ~= 0,
            rating_vec_new(i) = rating_vec(i) - mu;
            rating_vec_new(i) = rating_vec_new(i) - bx;
            rating_vec_new(i) = rating_vec_new(i) - bxj_vec(i);
        end
    end
    
    r = estimate_rating(sim_col_x, rating_vec_new, I);
end