load('ii_mat.mat');

% The assignment requires that K = 20.
K = 20;

%% Get user-user matrix
uu_mat = ii_mat';

%% Calculate normalized ratings
normalize_uu_mat = uu_mat;
for i = 1:size(user_total),
    normalize_uu_mat(i, :) = normalize_row(uu_mat(i, :));
end

%% Calculate user-user similarity

% uu_mat_sim(i, j) = sim means user#i and user#j have pearson similarity
% values sim. (After normalized)
uu_mat_sim = zeros(user_total, user_total);

for i = 1:(user_total - 1),
    uu_mat_sim(i, i) = 1.0;
    for j = (i + 1):user_total,
        fprintf('Calculating: i = %d, j = %d.\n', i, j);
        tic
        user_i = normalize_uu_mat(i, :);
        user_j = normalize_uu_mat(j, :);
        sim = pearson_sim(user_i, user_j);
        uu_mat_sim(i, j) = sim;
        uu_mat_sim(j, i) = sim;
        toc
    end
end
uu_mat_sim(user_total, user_total) = 1.0;

save('step2');