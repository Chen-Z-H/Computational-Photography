% H = compute_homography(points1, points2)
%
% Method: Determines the mapping H * points1 = points2
% 
% Input:  points1, points2 are of the form (3,n) with 
%         n is the number of points.
%         The points should be normalized for 
%         better performance.
% 
% Output: H 3x3 matrix 
%

function H = compute_homography( points1, points2 )
% points1: ref
% points2: c
%-------------------------
% TODO: FILL IN THIS PART
view = isnan(points2(1, 1)) + 1;     % 1: view 1; 2: view 2 
points2(isnan(points2)) = [];
points2 = reshape(points2, [3, numel(points2) / 3]);

n = size(points2, 2);
numpoints = size(points1, 2);   % num of all pairs
Q = zeros(2 * n, 9);
bias = 0;
if view == 2
    bias = numpoints - n;
elseif view == 3
    n = numpoints;
end
% view
% bias

for i = 1:n
    alpha = [points2(1, i), points2(2, i), 1,...
            0, 0, 0,...
            -points2(1, i) * points1(1, i + bias), -points2(2, i) * points1(1, i + bias), -points1(1, i + bias)];
    beta = [0, 0, 0,...
            points2(1, i), points2(2, i), 1,...
            -points2(1, i) * points1(2, i + bias), -points2(2, i) * points1(2, i + bias), -points1(2, i + bias)];

    Q(i, :) = alpha;
    Q(i + n, :) = beta;
end
% Q
[~, ~, V] = svd(Q);
% V(:, end)
H = reshape(V(:, end), [3, 3])';

end

