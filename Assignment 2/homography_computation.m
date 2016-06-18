clear all 
close all

%reading images
img1 = imresize(imread('Ajanta_1.jpg'),0.25);
img2 = imresize(imread('Ajanta_2.jpg'),0.25);
img3 = imresize(imread('Ajanta_2.jpg'),0.25);

%detecting keypoints
[points1,points2] = km_siftMatch(img1, img2); % Finding matching sift feature points in the images

%computing transforms from detected features
transform1 = cp2tform(points1,points2,'projective'); 

[points3,points4] = km_siftMatch(img2, img3); % Finding matching sift feature points in the images

%computing transforms from detected features
transform2 = cp2tform(points3,points4,'projective');

[points5,points6] = km_siftMatch(img1, img3); % Finding matching sift feature points in the images

%computing transforms from detected features
transform3 = cp2tform(points5,points6,'projective');