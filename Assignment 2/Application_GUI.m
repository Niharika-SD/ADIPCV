function Application_GUI(filename)
close all;

%reading the image
input_image = imresize(imread(filename),0.25);

figure,imshow(input_image);

fprintf('Select the input points starting from the top right corner clockwise ');

%taking user input
inputs = ginput(4);

%setting correspondences
output(1,:) = inputs(1,:);
output(2,1) = inputs(1,1);
output(2,2) = inputs(2,2);
output(3,1) = inputs(3,1);
output(3,2) = inputs(2,2);
output(4,1) = inputs(3,1);
output(4,2) = inputs(1,2);

%geometric transformation
tform = cp2tform(inputs,output,'projective');
output_image = imtransform(input_image,tform);

%display output image
figure,imshow(output_image);
