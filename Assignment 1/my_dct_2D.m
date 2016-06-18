function a = my_dct_2D(b)
[m, n] = size(b);
 a = my_dct_1D(my_dct_1D(b).').';
end