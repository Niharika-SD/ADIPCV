function [ optimum_labels ] = K_Means_hist( histogram_matrix, k, max_iterations, init )

optimum_cost = inf;

fprintf(['k: ' num2str(k)]);
fprintf(['\n num_init: ' num2str(init)]);
fprintf(['\n max_iter: ' num2str(max_iterations)]);

for t = 1:init,
    
    % Random Init
    fprintf(['\n\nInit ' num2str(t) ': ']); 
    
    %storing the centroid
    centroid = rand(k,size(histogram_matrix,2));
    stopTraining = 0;
    iter = 0;

    while (~stopTraining ==1),

        iter = iter + 1;
        centroid_old = centroid;

        % Calculating the labels
        [~, labels] = min(pdist2( centroid,histogram_matrix, 'euclidean'), [], 2);

        % Calculating the new centroid
        for i = 1:k,
            centroid(i,:) = mean(histogram_matrix(labels==i,:));
        end

        % Check if convergence has been reached or if max_iter is reached
        Err_absoulte = centroid_old(:) - centroid(:);
        
        if all(abs(Err_absoulte) < 10e-4),
                disp('Converged'); 
                stopTraining = 1;
        elseif iter == max_iterations,
            disp('Maximum Iterations');
            stopTraining = 1;
        end
    end
    
    %calculating penalty
    penalty = 0;
    dist_mat = pdist2(histogram_matrix, centroid, 'euclidean');
    for i = 1:k,
        penalty = penalty + sum(dist_mat(labels==i,i));
    end
    
    if ( penalty < optimum_cost ),
        optimum_cost = penalty;
        optimum_labels = labels;
    end
        
    
    fprintf(['current cost: ' num2str(penalty)]); 
    fprintf(['  Optimum Cost: ' num2str(optimum_cost)]); 
    
    
end
    



end
