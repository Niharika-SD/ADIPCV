clear all;
close all;

%user input for reading image
n = input('Enter a number between 0 and 5 : ');

switch n
    case 0
        I1_1 = imread('DSC_0244.jpg');
        I2_1 = imread('DSC_0245.JPG');
    case 1
        I1_1 = imread('DSC_0244.jpg');
        I2_1 = imread('DSC_0246.JPG');
    case 2
        I1_1 = imread('DSC_0244.jpg');
        I2_1 = imread('DSC_0247.JPG');
    case 3
        I1_1 = imread('DSC_0245.JPG');
        I2_1 = imread('DSC_0246.JPG');
    case 4
        I1_1 = imread('DSC_0245.JPG');
        I2_1 = imread('DSC_0247.JPG');
    case 5
        I1_1 = imread('DSC_0246.JPG');
        I2_1 = imread('DSC_0247.JPG');
 
end

i=size(I1_1)/size(I2_1);

I2_1 =imresize(I2_1,i);

I1=rgb2gray(I1_1);
I2 =rgb2gray(I2_1);

%histogram equalisation for matching intensities
I_2 = adapthisteq(I2,'ClipLimit',0.03);
I_1 = adapthisteq(I1,'ClipLimit',0.03);

%detecting features for matching
points1 = detectSURFFeatures(I_1);
points2 = detectSURFFeatures(I_2);

[features1,valid_points1] = extractFeatures(I_1,points1);
[features2,valid_points2] = extractFeatures(I_2,points2);
indexPairs = matchFeatures(features1,features2);

%finding inlier points
matchedPoints1 = valid_points1(indexPairs(:,1),:);
matchedPoints2 = valid_points2(indexPairs(:,2),:);

%display the matched features
showMatchedFeatures(I1_1,I2_1,matchedPoints1,matchedPoints2,'montage','PlotOptions',{'ro','go','y--'});
title('Putative point matches');

%estimation of fundamental matrix
[fLMedS, inliers] = estimateFundamentalMatrix(matchedPoints1,matchedPoints2,'NumTrials',4000);
fNorm8Point = estimateFundamentalMatrix(matchedPoints1,matchedPoints2);

%display inliers
figure;
showMatchedFeatures(I1_1, I2_1, matchedPoints1(inliers,:),matchedPoints2(inliers,:),'montage','PlotOptions',{'ro','go','y--'});
title('Point matches after outliers were removed');

%extracting location of matched features
Points_1 = double(matchedPoints1.Location);
Points_2 = double(matchedPoints2.Location);

%%

%calculating epipolar lines and epipoles

figure;

subplot(121); imshow(I1_1,'DisplayRange',[]);
title('Epipolar Line in First Images and epipole (intersection pt)'); hold on;
epiLines = epipolarLine(fLMedS', Points_2(inliers, :));
points = lineToBorderPoints(epiLines, size(I1));
line(points(:, [1,3])', points(:, [2,4])');

subplot(122); imshow(I2_1,'DisplayRange',[]);
title('Epipolar Lines in Second Images and epipole (intersection pt.)'); hold on;
epiLines_1 = epipolarLine(fLMedS, Points_1(inliers, :));
points_1 = lineToBorderPoints(epiLines_1, size(I2));
line(points_1(:, [1,3])', points_1(:, [2,4])');

%truesize;
[ep1,ep2] = Epipoles(fLMedS);

disp('epipole locations')
disp('epipole 1')
disp(ep1);
disp('epipole 2')
disp(ep2);
%%
% Calculating the camera calibration matrix 

[P1,P2,m,ep2] = FundamentalMatrixToCameraMatrix(fLMedS);

m1 = size(Points_1,1);
app = ones(1,m1);

Points_1 = Points_1';
Points_1 = [Points_1;app];
x1 = Points_1';

Points_2 = Points_2';
Points_2 = [Points_2;app];
x2 = Points_2';

%%

%Calculating 3-D correspondences by triangulation

x11 = x1'; 
x22 = x2'; 
   for i=1:size(x11,2)
       %Select point
       
       s1 = x11(:,i);
       s2 = x22(:,i);
       
       A_1 = s1(1,1).*P1(3,:) - P1(1,:);
       A_2 = s1(2,1).*P1(3,:) - P1(2,:);
       A_3 = s2(1,1).*P2(3,:) - P2(1,:);
       A_4 = s2(2,1).*P2(3,:) - P2(2,:);
       %Set A matrix, and find SDV(A)
       
       A = [A_1;A_2;A_3;A_4];
       [U,D,V] = svd(A);
      
       %Point in 3D space is the last column of V
       
       Xtemp = V(:,4);
       Xtemp = Xtemp ./ repmat(Xtemp(4,1),4,1); 
       Xw(:,i) = Xtemp;
   end
   disp('3-D Locations')
   disp(Xw)