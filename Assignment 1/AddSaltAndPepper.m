function  b = AddSaltAndPepper(img,p)
    sizeA = size(img);
    b = img;
    x = rand(sizeA);
    b(x < p/2) = 0; % Minimum value
    b(x >= p/2 & x < p) = 255; %Maximum value
end