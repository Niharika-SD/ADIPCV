function output = inverseDCT_2D(input)
[m,n] =size(input);
output = iinverseDCT_1D(idct(input).').';
end