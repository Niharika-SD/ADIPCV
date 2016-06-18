 
Execute the following

1.Run the script : compute_fund_mat.m
2.Enter User input to select the set of images (0-5)
 0  DSC_0244.jpg and DSC_0245.jpg
 1  DSC_0244.jpg and DSC_0246.jpg
 2  DSC_0244.jpg and DSC_0247.jpg
 3  DSC_0245.jpg and DSC_0246.jpg
 4  DSC_0245.jpg and DSC_0247.jpg
 5  DSC_0246.jpg and DSC_0247.jpg

Functions used:

The second image read is resized according to the first and intensity normalisation is done using CLAHE to compensate for changes in the dynamic ranges of the two images. Feature mapping is then done by using SURF algorithm and the matches of the points are displayed. Outliers are removed using RANSAC. (Results obtained may differ from run to run depending on the convergence of the algorithm)

1.EstimateFundamentalMatrix: This function takes input as the point matches and computes the fundamental matrix using 8 Point algorithm.

2.epipolarLine: This function takes the first argument as the fundamental matrix and the second as the points from the second image and computes points on the epiploar line. These points are then joined to form the epipolar lines and then displayed on the image.

The intersection of the epipolar lines is the epipole and may lie inside or outside the range of the image.

3.Epipoles: takes input as the fundamental matrix(f) and calculates the epipoles(output arguments) by finding the null space of f.
  
4.FundamentalMatrixToCameraMatrix: Takes the fundamental matrix as input and gives the camera calibration matrices p1 and p2 as output using skew symmetric property of f.

5.Triangulation is used to find the 3-D point correspondences.


The computed epipoles are stored in ep1 and ep2 and the 3-D points in variable Xw and are displayed on the command window
