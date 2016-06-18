function [ best_labels ] = K_means( hist_mat, K, max_iter, num_init )
% Perform K-means
% Input params:
%   hist_mat - Histogram of all the input images
%   K - no of clusters
%   max_iter - Maximum number of iteration incase convergence is not
%     achieved
%   num_init - Number of initialisations
% Output:
%   best_labels - returns the labels assigned for the least cost clustering
%   among the initialisations
 

best_cost = inf;
fprintf(['K: ' num2str(K)]);
fprintf(['\nnum_init: ' num2str(num_init)]);
fprintf(['\nmax_iter: ' num2str(max_iter)]);

for t = 1:num_init,
    
    % Random Init
    fprintf(['\n\nInit ' num2str(t) ': ']); 
    mu = rand(K,size(hist_mat,2));
    continueTraining = 1;
    iter = 0;

    while continueTraining,

        iter = iter + 1;
        mu_old = mu;

        % Assign Labels
        [~, labels] = min(pdist2(hist_mat, mu, 'euclidean'), [], 2);

        % Assign Centroids
        for i = 1:K,
            mu(i,:) = mean(hist_mat(labels==i,:));
        end

        % Check if mu has changed or if max_iter is reached
        absErr = mu_old(:) - mu(:);
        if all(abs(absErr) < 1e-3),
                disp('Convergence Achieved'); 
                continueTraining = 0;
        elseif iter == max_iter,
            disp('Max Iter Reached. Break without convergence');
            continueTraining = 0;
        end
    end
    
    cost = 0;
    dist_mat = pdist2(hist_mat, mu, 'euclidean');
    for i = 1:K,
        cost = cost + sum(dist_mat(labels==i,i));
    end
    
    if ( cost < best_cost ),
        best_cost = cost;
        best_labels = labels;
    end
        
    
    fprintf(['Cost obtained for current initialisation: ' num2str(cost) '\n']); 
    fprintf(['Current Best Cost: ' num2str(best_cost)]); 
    
    
end
    



end

