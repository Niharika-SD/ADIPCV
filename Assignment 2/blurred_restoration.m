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

% Superimposing the 2 transformed images after performing histogram equalisation
ims2=max(im1trans,im2trans); 
figure,imshow(ims2),title('Stitched images');

img_blurred = imresize(imread('Ajanta_blurred.jpg'),0.25);
figure,imshow(img_blurred),title('blurred image');
[m,n,p]=size(img_blurred);
ims2 = bilinearInterpolation(ims2,[m,n]);
[points1,points2] = km_siftMatch(ims2, img_blurred); % Finding matching sift feature points in the images

%computing transforms from detected features
transform = cp2tform(points2,points1,'projective'); 
[img1_tf,xdata2,ydata2] = imtransform(img_blurred,transform); 

% Finding the extremum points after transformation
xdataout = [min(1,xdata2(1)) max(size(ims2,2),xdata2(2))]; 
ydataout = [min(1,ydata2(1)) max(size(ims2,1),ydata2(2))];

% Restricting the transformed output to the geometric bound
im1trans = imtransform(img_blurred,transform,'XData',xdataout,'YData',ydataout); 
im2trans = imtransform(ims2,maketform('affine',eye(3)),'XData',xdataout,'YData',ydataout);

% Superimposing the 2 transformed images after performing histogram equalisation
ims2=max(im1trans,im2trans); 
ims2 = ims2(size(img_blurred,1)*0.20:size(img_blurred,1),size(img_blurred,2)*0.10:size(img_blurred,2)*0.9,:);
ims2 = imresize(ims2, [size(img_blurred,1),size(img_blurred,2)]);
figure,imshow(ims2),title('Restored view')

