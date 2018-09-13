% Method:   compute all normalization matrices.  
%           It is: point_norm = norm_matrix * point. The norm_points 
%           have centroid 0 and average distance = sqrt(2))
% 
%           Let N be the number of points and C the number of cameras.
%
% Input:    points2d is a 3xNxC array. Stores un-normalized homogeneous
%           coordinates for points in 2D. The data may have NaN values.
%        
% Output:   norm_mat is a 3x3xC array. Stores the normalization matrices
%           for all cameras, i.e. norm_mat(:,:,c) is the normalization
%           matrix for camera c.

function norm_mat = compute_normalization_matrices( points2d )

%-------------------------
% TODO: FILL IN THIS PART
% Still, we need to remove all the NaNs for each matrix at first
norm_mat = zeros(3, 3, 3);
[~, ~, n] = size(points2d);

for i = 1:n
    points = points2d(:,:,i);
    % Remove the NaN and reshape it
    points(isnan(points)) = [];

    numpoints = numel(points) / 3;
    points = reshape(points, [3, numpoints]);
    pc = mean(points, 2);
    dc = sum(sqrt(sum((points - repmat(pc, 1, numpoints)).^2))) / numpoints;
    Nc = sqrt(2)/dc * [1, 0, -pc(1); 0, 1, -pc(2); 0, 0, dc/sqrt(2)];
    norm_mat(:, :, i) = Nc;
end




