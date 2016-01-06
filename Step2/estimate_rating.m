function [ r ] = estimate_rating( sim_col_x, rating_vec, I)
%ESTIMATE_RATING Summary of this function goes here
%   Demo on lect-recom page 30 (Predict by taking weighted average):
%   sim_col_x: example: [1.00, -0.18, 0.41, -0.10, -0.31, 0.59]
%   rating_vec: example: [0, 0, 2, 5, 4, 3]
%   I: 1
    assert(length(sim_col_x) == length(rating_vec), 'length of sim_col_x should equals to length of rating_vec');
    
    len = length(sim_col_x);
    numerator = 0;
    denominator = 0;
    
    for i = 1:len,
       if (sim_col_x(i) <= 0) || (i == I),
           continue;
       else
           numerator = numerator + sim_col_x(i) * rating_vec(i);
           denominator = denominator + sim_col_x(i);
       end
    end
    
    if denominator == 0,
        % denominator = 0 means that there's no positive similarity row
        r = 0;
    else
        r = numerator / denominator;
    end
end

