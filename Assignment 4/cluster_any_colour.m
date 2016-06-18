function [img_output] = cluster_any_colour(input,M_norm,Right,Left)
inp
clust = M_norm(Left-359:Right-359,:,:,:,:);
img_output = zeros(size(input));

[m,n,p] = size(input);

for i=1:m
    for j = 1:n
         angle = atan2((input(i,j,2)-(1/3)),(input(i,j,1)-1/3))*180/pi;
        [~,idx] = min( abs(angle - M_norm(:,5)) );
        %clustering
        if( M_norm(idx,1) >= Left && M_norm(idx,1) <= Right),
                img_output(i,j,:,:,:) = input(i,j,:,:,:);
         
        end
    end
end


end