close all;
clear all;
%reading the images
A=imread('cap.bmp');
B=imread('lego.tif');

%rgb to gray conversion
[m,n]= size(A);
C = (0.2989*B(:,:,1)+0.5870*B(:,:,2)+0.1140*B(:,:,3))/3;
figure; imshow(C,[]);
title('After rgb to grayscale conversion');

%adding salt and pepper noise
prompt = 'Enter value of p: ';
p = input(prompt);
img_noisy = AddSaltAndPepper(A,p);

%image denoising and PSNR calculation
D = zeros(m,n); 
D(:,:) = img_noisy;
mean_filtered = mat2gray(mean_filt(D));
median_filtered = mat2gray(median_filt(D));

%displaying images
figure;imshow(A);
title('original');
figure;imshow(imresize(img_noisy,[m,n]));
title('noisy image');
figure;imshow(imresize(mean_filtered,[m,n]));
title('mean filtered image');
figure;imshow(median_filtered);
title('median filtered image');
 
q = 0.05:0.05:1;
%computing and plotting PSNR values
for i = 1:length(q)
img_noisy_1 = AddSaltAndPepper(A,q(i));
D(:,:) = img_noisy_1;
mean_filtered = mat2gray(mean_filt(D));
median_filtered = mat2gray(median_filt(D));
PSNR_noisy(i) = PSNR(img_noisy_1,A);
PSNR_mean(i) = PSNR(mean_filtered,A);
PSNR_median(i) = PSNR(median_filtered,A);
end

figure;plot(q,PSNR_noisy);
title('PSNR noisy');
figure;plot(q,PSNR_mean);
title('PSNR mean filter');
figure;plot(q,PSNR_median);
title('PSNR median filter');

%edge and gradient operations
[a2,b2,c2] = my_sobel(double(C));
level = multithresh(a2);
a2 = imquantize(a2,level);
figure;imshow(a2,[]); %x gradient
title('x gradient image');
level = multithresh(b2);
b2 = imquantize(b2,level);
figure;imshow(b2,[]); %y gradient
title('y gradient image');
c2 = double(c2);
level = multithresh(c2);
c2 = imquantize(c2,level);
figure;imshow(c2,[]); %magnitude
title('magnitude of gradient image');

%discrete cosine transform
[m1,n1] = size(A);
a = ceil(m1/8);
r = mod(m1,8);
b = ceil(n1/8);
c = mod(n1,8);
E = padarray(A,[r,c],0,'post');
k = 8*ones(1,a);
l = 8*ones(1,b);
c = mat2cell(E,k,l);
for i = 1: a
    for j =1:b
        if (j==1)
        d = my_dct_2D(double(c{i,j}));
        else
        e = my_dct_2D(double(c{i,j}));
        d = horzcat(d,e);
        end
    end
        if(i == 1)
        d1 = d;
        else
        d1 = vertcat(d1,d);
        end

end
figure;imshow(d1);
title('DCT transformed image');

%inverse discrete cosine transform
c1 = mat2cell(d1,k,l);
for i = 1: a
    for j =1:b
        if (j==1)
        f = my_dct_2D(double(c1{i,j}));
        else
        e1 = my_dct_2D(double(c1{i,j}));
        f = horzcat(f,e1);
        end
    end
        if(i == 1)
        f1 = f;
        else
        f1 = vertcat(f1,f);
        end

end
figure;imshow(f1,[]);
title('inverse DCT transformed image');

%harris corner detector
[corner,r,c] = harris(C);


