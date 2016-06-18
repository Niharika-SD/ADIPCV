function [edgeImage_x,edgeImage_y,magnitude] = my_sobel(originalImage) 
assert(all(size(originalImage) <= [2048 2048]));

k = [1 2 1; 0 0 0; -1 -2 -1];
H = conv2(double(originalImage),k, 'same');
H = imresize(H,size(originalImage));

V = conv2(double(originalImage),k','same');
V =imresize(V,size(originalImage));
magnitude = sqrt(H.*H + V.*V);
level = graythresh(originalImage);
edgeImage_x = im2bw(H,level);
edgeImage_y = im2bw(V,level);
edgeImage_x = uint8((edgeImage_x>0) * 255);
edgeImage_y = uint8((edgeImage_y >0) * 255);
