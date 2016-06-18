function a = iinverseDCT_1D(b)
if isempty(b),
   a = [];
   return
end
if (size(b,1) == 1) 
    b = b(:);
end
 n = size(b,1);
 m = size(b,2);
 
 % Pad or truncate b if necessary
if size(b,1)<n,
  bb = zeros(n,m);
  bb(1:size(b,1),:) = b;
else
  bb = b(1:n,:);
end
 % Compute wieghts
ww = sqrt(2*n) * exp(1i*(0:n-1)*pi/(2*n)).';

if rem(n,2)==1 || ~isreal(b), % odd case
  % Form intermediate even-symmetric matrix.
  ww(1) = ww(1) * sqrt(2);
  W = ww(:,ones(1,m));
  yy = zeros(2*n,m);
  yy(1:n,:) = W.*bb;
  yy(n+2:2*n,:) = -1i*W(2:n,:).*flipud(bb(2:n,:));
  
  y = ifft(yy);

  % Extract inverse DCT
  a = y(1:n,:);

else % even case
  % Compute precorrection factor
  ww(1) = ww(1)/sqrt(2);
  W = ww(:,ones(1,m));
  yy = W.*bb;

    y = ifft(yy);
  
  a = zeros(n,m);
  a(1:2:n,:) = y(1:n/2,:);
  a(2:2:n,:) = y(n:-1:n/2+1,:);
end

if isreal(b), a = real(a); end
if (size(b,1) == 1)
    a = a.'; 
end
end