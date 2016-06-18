function ss = SkewSymmetricMatrix(A)
% Input:
%       - matrixA is a 3x1 or a 1x3 vector.
% 
% Output:
%       - S is a 3x3 matrix with the form:
%         _        _
%        |0 -a3  a2 |
%        |a3  0 -a1 |
%        |-a2 a1  0 |
%        -          -
%

if (size(A,2)==3)
    A = A'
end

ss = [ 0           -A(3)   A(2); ...
      A(3)   0           -A(1); ... 
	 -A(2)   A(1)   0 ];
