=================================
Assignment-3: HUE FILTRATION AND COLOR MATCHING
Code By Sai Srivatsa R
Roll No: 12EE10059
=================================

Instructions for running
=================================

1. Add the required images to the 'imgs' folder
2. Run demo.m
>>demo

Default Parameters
=================================

To change the values, goto demo.m ( Line 65 - Line 82 )
Default values are as shown

To set number of bins for histogram
n_bins = 10

To set number of Clusters
K = 3

To set max number of iterations in K-Means
max_iter = 10000

To set number of random initialisations in K-Means
num_init = 10

To resize images for faster computations, set doResize. (Images are resize to 30% of original size)
doResize = true

Tp preload saved histograms, set usePreloadHist
usePreloadHist = true

Undertsanding the Output
=================================

Outputs for part-1 and part-2 appear as figures. For part-3, a folder names 'clusters' 
is created and the results are stored in it.

Contents of the folder
=================================

.m files
1. demo.m : Script to run for evalutaion
2. filter_wavelength.m : Given an image, filters out all pixels whose wavelength doesnt belong
to the specified range
3. compute_wavehist.m: Computes normed histogram in wavelength space of a given image
4. K_means.m: Computes K-means clustering using wavelength histograms for images in the imgs folder

.mat files
1. hist_mat: Precomputed wavelength histogram (10 bins) for the images in 'imgs' folder

folders
1. imgs: Consists of input images
2. clusters: Created by the script for storing K-Means result. 
clusters/1 subfolder consists of all images belonging to cluster 1
clusters/2 subfolder consists of all images belonging to cluster 2 ...