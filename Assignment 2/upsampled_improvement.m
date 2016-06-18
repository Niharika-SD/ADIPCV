clear all
close all
img1 = imresize(imread('Ajanta_1.jpg'),0.25);
img2 = imresize(imread('Ajanta_2.jpg'),0.25);

%detecting keypoints
[points1,points2] = km_siftMatch(img1, img2); % Finding matching sift feature points in the images

%computing transforms from detected features
transform = cp2tform(points2,points1,'projective'); 

%transforming the image 1 to view of image 2
[img1_tf,xdata2,ydata2] = imtransform(img2,transform); 

% Finding the extremum points after transformation
xdataout = [min(1,xdata2(1)) max(size(img1,2),xdata2(2))]; 
ydataout = [min(1,ydata2(1)) max(size(img1,1),ydata2(2))];

% Restricting the transformed output to the geometric bound
im1trans = imtransform(img2,transform,'XData',xdataout,'YData',ydataout); 
im2trans = imtransform(img1,maketform('affine',eye(3)),'XData',xdataout,'YData',ydataout);

figure;
subplot(2,2,1),imshow(img1),title('Ajanta_1 original'),
subplot(2,2,2),imshow(img2),title('Ajanta_2 original');
subplot(2,2,3),imshow(im1trans),title(' Ajanta 1(After Transformation)'),
subplot(2,2,4),imshow(im2trans),title(' Ajanta 2(After Transformation)');

% Superimposing the 2 transformed images after performing histogram equalisation
cmap1 = rgb2hsv(im1trans);
cmap2 = rgb2hsv(im2trans);
cmap1(:,:,3) = adapthisteq(cmap1(:,:,3));
cmap2(:,:,3) = adapthisteq(cmap2(:,:,3));

ims2=max(hsv2rgb(cmap1),hsv2rgb(cmap2)); 
ims2 = ims2(1:size(img1,1),1:0.9*size(img1,2),:);
figure,imshow(ims2);
title('restored image');

%interpolating

img_out = bilinearInterpolation(ims2,[size(img1,1),size(img1,2)]*2);
figure,imshow(img_out);
title('restored image after interpolation');