%% Final Project - Problem2 - normalize.m
% Created by 1352847 Junpeng Ouyang on Jan 6, 2015. All rights reserved.

%% Function implementation

function [ norm_row ] = normalize_row( row )
%NORMALIZE_ROW Summary of this function goes here
%   Detailed explanation goes here
    len = length(row);
    norm_row = zeros(1, len);
    avg_non_zero = mean(row(row ~= 0));
    for i = 1:len,
        if row(i) == 0,
            continue;
        else
            norm_row(i) = row(i) - avg_non_zero;
        end
    end
end
