%% Compute homographies
% Determine all homographies to a reference view. We have:
% point in REFERENCE_VIEW = homographies(:,:,c) * point in image c.
% Remember, you have to set homographies{REFERENCE_VIEW} as well.
homographies = zeros(3,3,CAMERAS);

%-------------------------
% TODO: FILL IN THIS PART
% non-normalized version
for c=1:CAMERAS
    points_ref = points2d(:,:,REFERENCE_VIEW);
    points_c   = points2d(:,:,c);
    
    homographies(:,:,c) = compute_homography( points_ref, points_c );
end

% % normalized version
% points2d_norm = zeros(size(points2d));
% norm_mat = compute_normalization_matrices( points2d );
% for c = 1:CAMERAS
%     points2d_norm(:,:,c) = norm_mat(:,:,c) * points2d(:,:,c);
% end
% % The result of the following calling should be three indentity matrices
% % compute_normalization_matrices(points2d_norm)
% 
% homographies_norm = zeros(size(homographies));
% for c = 1:CAMERAS
%     points_ref = points2d_norm(:,:,REFERENCE_VIEW);
%     points_c   = points2d_norm(:,:,c);
%     homographies_norm(:,:,c) = compute_homography( points_ref, points_c );
%     homographies(:,:,c) = inv(norm_mat(:,:,REFERENCE_VIEW)) * homographies_norm(:,:,c) * norm_mat(:,:,c);
% end


for c = 1:CAMERAS
    
    [error_mean error_max] = check_error_homographies( ...
      homographies(:,:,c), points2d(:,:,c), points2d(:,:,REFERENCE_VIEW) );
 
    fprintf( 'Between view %d and ref. view; ', c );
    fprintf( 'average error: %5.2f; maximum error: %5.2f \n', error_mean, error_max );
end


%% Generate, draw and save panorama

panorama_image = generate_panorama_alt( images, homographies );

figure;  
show_image_grey( panorama_image );
save_image_grey( name_panorama, panorama_image );