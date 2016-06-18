function cosine = my_dct_1D(input)
if isempty(input)
   cosine = [];
   return
end
if (size(input,1) == 1)
    input = input(:);
end
n = size(input,1);
m = size(input,2);

% Pad or truncate input if necessary
if size(input,1)<n,
  aa = zeros(n,m);
  aa(1:size(input,1),:) = input;
else
  aa = input(1:n,:);
end

% Compute weights to multiply DFT coefficients
ww = (exp(-1i*(0:n-1)*pi/(2*n))/sqrt(2*n)).';
ww(1) = ww(1) / sqrt(2);

if rem(n,2)==1 || ~isreal(input), % odd case
  % Form intermediate even-symmetric matrix
  y = zeros(2*n,m);
  y(1:n,:) = aa;
  y(n+1:2*n,:) = flipud(aa);
  
  % Compute the FFT and keep the appropriate portion:
  yy = fft(y);  
  yy = yy(1:n,:);

else % even case
  % Re-order the elements of the columns of x
  y = [ aa(1:2:n,:); aa(n:-2:2,:) ];
  yy = fft(y);  
  ww = 2*ww;  % Double the weights for even-length case  
end

% Multiply FFT by weights:
cosine = ww(:,ones(1,m)) .* yy;

if isreal(input), cosine = real(cosine); end
if (size(input,1) == 1), cosine = cosine.'; end

end