%% Final Project - Problem2 - pearson_sim.m
% Created by 1352847 Junpeng Ouyang on Jan 6, 2015. All rights reserved.
% Reference: https://segmentfault.com/q/1010000000094674

%% Function implementation

function [ sim ] = cosine_sim( X, Y )
%COSINE_SIM Summary of this function goes here
%   Detailed explanation goes here
    assert(length(X) == length(Y), 'The length of X and Y in cosine_sim must be same!');
    
    numerator = sum(X .* Y);
    denominator = ( sum(X .^ 2) ^ 0.5 ) * ( sum(Y .^ 2) ^ 0.5 );
    
    sim = numerator / denominator;
    
end
