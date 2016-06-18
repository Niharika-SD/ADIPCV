function out = median_filt(image)
out = image;
[row, col] = size(out);
for x = 2:1:row-1
    for y = 2:1:col-1
a1 = [image(x-1,y-1) image(x-1,y) image(x-1,y+1) image(x,y-1) image(x,y) image(x,y+1) image(x+1,y-1) image(x+1,y) image(x+1,y+1)];
a2 = sort(a1);
med = a2(5);  
out(x,y) = med;
    end
end
end