%% Final Project - Problem2 - pearson_sim.m
% Created by 1352847 Junpeng Ouyang on Jan 6, 2015. All rights reserved.
% Reference: https://segmentfault.com/q/1010000000094674

%% Function implementation

function [ sim ] = pearson_sim( X, Y )
%PEARSON_SIM Summary of this function goes here
%   Detailed explanation goes here
    assert(length(X) == length(Y), 'The length of X and Y in person_sim must be same!');
    
    avg_X = mean(X);
    avg_Y = mean(Y);
    
    numerator = sum((X - avg_X) .* (Y - avg_Y));
    
    rxms = sum( (X - avg_X) .^ 2 ) ^ 0.5;
    ryms = sum( (Y - avg_Y) .^ 2 ) ^ 0.5;
    
    denominator = rxms * ryms;
    
    sim = numerator / denominator;
    
end

