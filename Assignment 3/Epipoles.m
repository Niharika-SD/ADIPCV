function [ep1,ep2] = Epipoles(f)
% Computes the epipoles as null vectors of the fundamental matrix.
%
% Input:
%		- f is the fundamental matrix.
%
% Output:
%		- ep1 and ep2 are the epipoles.
%
%----------------------------------------------------------

% epipole computation
[D, D, v] = svd(f);
ep1 = v(:,3)/v(3,3);

[D, D, v] = svd(f');
ep2 = v(:,3)/v(3,3);

