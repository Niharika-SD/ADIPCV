function [img_v,img_g,img_y] = colour_cluster(input_1,M_norm)
img = rgb2xyz(input_1);
%normalising the input image
input = normalise_xyz(img);

v_clust = M_norm(360-359:400-359,:,:,:,:);
g_clust = M_norm(495-359:569-359,:,:,:,:);
y_clust = M_norm(575-359:590-359,:,:,:,:);

img_v = zeros(size(input));
img_g = zeros(size(input));
img_y = zeros(size(input));

[m,n,p] = size(input);

for i=1:m
    for j = 1:n
        
        angle = atan2((input(i,j,2)-(1/3)),(input(i,j,1)-1/3))*180/pi;
        [~,idx] = min( abs(angle - M_norm(:,5)) );
        %clustering
        if( M_norm(idx,1) >= 360 && M_norm(idx,1) <= 400),
                img_v(i,j,:,:,:) = input_1(i,j,:,:,:);
        
        elseif( M_norm(idx,1) >= 490 && M_norm(idx,1) <= 569),
                img_g(i,j,:,:,:) = input_1(i,j,:,:,:);
                
        elseif( M_norm(idx,1) >= 577 && M_norm(idx,1) <= 585),
                img_y(i,j,:,:,:) = input_1(i,j,:,:,:);
                
        end
                  
    end
end
end