function img = normalise_chart(input)

[m,n] =size(input);
img = zeros(m,n);

CIE = input(:,2:4);

for i =1:m
    %wavelength 
    img(i,1) = input(i,1);
    %normalising x,y,z
    img(i,2) =input(i,2)/(input(i,2)+input(i,3)+input(i,4)) ;
    img(i,3) =input(i,3)/(input(i,2)+input(i,3)+input(i,4)) ;
    img(i,4) =input(i,4)/(input(i,2)+input(i,3)+input(i,4)) ;

end
%appending the angle value associated with each colour
img(:,5) = atan2( CIE(:,2)./sum(CIE,2) - 0.33, CIE(:,1)./sum(CIE,2) - 0.33)*180/pi;

end
