%rgb to gray

figure;subplot(2,1,1); imshow(C,[]);
title('rgb converter')
hold on
subplot(2,1,2); imshow(rgb2gray(B),[]);
title('original matlab function')
hold off

%Salt and pepper

figure;subplot(2,1,1); imshow(img_noisy,[]);
title('salt and pepper noise')
hold on
subplot(2,1,2); imshow(imnoise(A,'Salt & pepper',0.1),[]);
title('original matlab function')

%Mean filtered

figure;subplot(2,1,1); imshow(mean_filt(img_noisy),[]);
title('mean filtered')
hold on
h = fspecial('average'); 
D(:,:) = img_noisy;
mean_filtered_1 = mat2gray(imfilter(D,h));
subplot(2,1,2); imshow(mean_filtered_1,[]);
title('original matlab function')

%Median filtered

figure;subplot(2,1,1); imshow(median_filt(img_noisy),[]);
title('median filtered')
hold on 
D(:,:) = img_noisy;
median_filtered_1 = mat2gray(medfilt2(D));
subplot(2,1,2); imshow(median_filtered_1,[]);
title('original matlab function')

%sobel 

figure;subplot(2,1,1); imshow(a2,[]);
title('horizontal gradient')
hold on
h = fspecial('sobel');
J = imfilter(C,h);
subplot(2,1,2); imshow(J,[]);
title('original matlab function')

figure;subplot(2,1,1); imshow(b2,[]);
title('vertical gradient')
hold on
h = h' ;
J1 = imfilter(C,h);
subplot(2,1,2); imshow(J1,[]);
title('original matlab function')

figure;subplot(2,1,1); imshow(c2,[]);
title('magnitude')
hold on
E= sqrt(double(J1.^2 +J.^2));
subplot(2,1,2); imshow(E,[]);
title('original matlab function')

%DCT

figure;subplot(2,1,1); imshow(d1);
title('DCT')
hold on
D(:,:) = A;
dct1 = dct2(D);
subplot(2,1,2); imshow(dct1);
title('original matlab function')

%IDCT

figure;subplot(2,1,1); imshow(f1,[]);
title('IDCT')
hold on

D(:,:) = img_noisy;
idct1 = idct2(dct1);
subplot(2,1,2); imshow(idct1,[]);
title('original matlab function')

%harris corner
X =imread('cameraman.tif');
[corner,r,c] = harris(X);
title('harris corner')
I = corner(X,'Harris');
figure;imshow(X);
hold on
plot(I(:,1), I(:,2), 'ys');
title('original matlab function')

