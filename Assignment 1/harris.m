function [corner_image, r, c] = harris(image)
    
    threshold = 400;
    radius = 2;
    sigma = 2;
    
    dx = [-1 0 1; -1 0 1; -1 0 1]; % x derivative mask
    dy = [-1 -1,-1; 0 0 0 ; 1,1,1]; % y derivative mask
    
    Ix = conv2(image, dx, 'same');    % Image x derivative
    Iy = conv2(image, dy, 'same');    % Image y derivative

    % Smoothing of derivatives by gaussian filter
    
    g = fspecial('gaussian',max(1,fix(6*sigma)), sigma);
    Ix2 = conv2(Ix.^2, g, 'same'); 
    Iy2 = conv2(Iy.^2, g, 'same');
    Ixy = conv2(Ix.*Iy, g, 'same');
    
    corner_image = (Ix2.*Iy2 - Ixy.^2)./(Ix2 + Iy2 + eps); % corner measure 
	
    sze = 2*radius+1;                   
	maxima = ordfilt2(corner_image,sze^2,ones(sze)); 
    
	corner_image = (corner_image== maxima)&(corner_image>threshold);       % Finding maxima.
	
	[r,c] = find(corner_image); % Finding row,column co-ordinates.  
	figure; imshow(double(image),[]);
    hold on;
	for i = 1: length(r)
    plot(c(i),r(i),'ys');
    title('corners detected');
    end
    
end
 