1.Run Image_processing_primer.m and enter the value of p when prompted
2.  Functions used:
    a. rgb to gray scale conversion(in Image_processing_primer)
    b. SaltAndPepper : Adds salt and pepper noise, 1st argument is the image, 2nd argument is the probability
    c. mean_filt for performing mean filtering (3X3 mask), input argument is image
    d. median_filt for performing median filtering (3X3 mask), input argument is image
    e. my_sobel returns the horizontal, vertical gradients and gradient magnitude as 1st 2nd 3rd arguments respectively
    f. my_DCT_1D: performs 1D DCT operation on input matrix
    g. my_DCT_2D: performs 2D DCT operation on input image 
    h. iinverseDCT_1D: performs 1D DCT operation on input matrix
    i. inverseDCT_2D: performs 2D DCT operation on input image 
    j. harris: computes corners using Harris corner detection algorithm and displays the detected corners on the input image
 3. Run comparison.m for the comparison with library operations (Do not clear the variables)