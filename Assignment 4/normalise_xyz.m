function img = normalise_xyz(input)
[m,n,p] =size(input);
img = zeros(m,n);
for i =1:m
for j=1:n
img(i,j,1) =input(i,j,1)/(input(i,j,1)+input(i,j,2)+input(i,j,3)) ;
img(i,j,2) =input(i,j,2)/(input(i,j,1)+input(i,j,2)+input(i,j,3)) ;
img(i,j,3) =input(i,j,3);
end
end

end