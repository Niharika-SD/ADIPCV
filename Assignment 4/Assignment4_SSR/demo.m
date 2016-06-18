% Script for Assignment-4
% Automatically runs the code for evalutation
% Code by Sai Srivatsa Ravindranath
% Roll No: 12EE10059

clc; clear; close all;
addpath('imgs');
chart = csvread('ciexyz31_1.csv');
img_files = dir('imgs\*.jpg');

%% Part - 1
% Filter Based on Wavelength

disp('PART-1');
img = imread('peppers.png');

figure;
subplot(2,2,1);
imshow(img);
title('Source Image');

subplot(2,2,2);
% Violet : 360 - 400nm
filter_wavelength(img, 360, 400, chart);

subplot(2,2,3);
% Yellow : 575 - 590nm
filter_wavelength(img, 575, 590, chart);

subplot(2,2,4);
% Red : 600 - 620nm
filter_wavelength(img, 600, 620, chart);

disp('Displaying Filtered Images with Violet, Yellow and Red wavelength Ranges');


%% Part - 2
% Compute Histogram

fprintf('\n\n');
disp('PART-2');

doPlot = true;
doResize = true;
n_bins = 10;

hist_mat = zeros(length(img_files),n_bins);
figure;
disp('Reading Images and Computing Norm-histogram in wavelength space');
for i = 1:5,
    subplot(5,1,i);
    hist_mat(i,:) = compute_wavehist( img_files(i).name, chart, n_bins, doResize, doPlot )';
    fprintf('.');
end

fprintf('\n');
disp('Displaying Hisogram Plot');

%% Part - 3
% Clustering

fprintf('\n\nPART-3\n');

% Default Values

% Number of bins for histogram
n_bins = 10;

% Number of Clusters
K = 3;

% Number of iterations in K-Means
max_iter = 10000;

% Number of random initialisations in K-Means
num_init = 10;

% Set this to true for faster computations
doResize = true;

% Set this to true for preloading saved histograms
usePreloadHist = true;
 
if usePreloadHist,
    % Preload Saved Histogram for faster computation
    % set usePreloadHist to false if you want to compute the histograms
    % as part of the program.
    disp('Using Preloaded Histograms, (you can disable this option in the script).');
    hist_mat_strt = load('hist_mat');
    hist_mat = hist_mat_strt.hist_mat;
else    
    disp('Reading Images and Computing Histogram');
    disp('Takes some time...');

    hist_mat = zeros(length(img_files),n_bins);
    for i = 1:length(img_files),
        hist_mat(i,:) = compute_wavehist( img_files(i).name, chart, n_bins, doResize, false )';
        fprintf('.');
    end

    fprintf('\n');
end

fprintf('\nPerforming K-means\n');
labels = K_means( hist_mat, K, max_iter, num_init )';
mkdir('clusters');

for i = 1:K,
    mkdir(['clusters/' num2str(i)]);
end

fprintf('\n\nSaving images\n');
for i = 1:length(img_files),
    imwrite(imread(img_files(i).name),['clusters/' num2str(labels(i)) '/' img_files(i).name]);
    fprintf('.');
end

fprintf('\nClustering complete. Check clusters folder.\n')
fprintf('Its possible that a cluster has no assigned images. Re-run K-means with larger value of num_init\n');

    



