clear all 
close all

%reading images
img1 = imresize(imread('Ajanta_1.jpg'),0.25);
img2 = imresize(imread('Ajanta_2.jpg'),0.25);

%detecting keypoints
[points1,points2] = km_siftMatch(img1, img2); % Finding matching sift feature points in the images

%computing transforms from detected features
transform = cp2tform(points1,points2,'projective'); 

%transforming the image 1 to view of image 2
[img1_tf,xdata2,ydata2] = imtransform(img1,transform); 

% Finding the extremum points after transformation
xdataout = [min(1,xdata2(1)) max(size(img2,2),xdata2(2))]; 
ydataout = [min(1,ydata2(1)) max(size(img2,1),ydata2(2))];

% Restricting the transformed output to the geometric bound
im1trans = imtransform(img1,transform,'XData',xdataout,'YData',ydataout); 
im2trans = imtransform(img2,maketform('affine',eye(3)),'XData',xdataout,'YData',ydataout);

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
figure,imshow(ims2),title('Stitched images');