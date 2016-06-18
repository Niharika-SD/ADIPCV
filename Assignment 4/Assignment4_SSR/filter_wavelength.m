function [ filt_img ] = filter_wavelength( img, wave_L, wave_R, chart )
% Filters image based on wavelength range
% Input Params:
%   img - source image
%   wave_L - left limit of wavelength range
%   wave_R - right limit of wavelength range
%   Chart - Wavelength CIE-chart stored in the following format for each
%   row: [ Wavelength X Y Z ] 
% Output:
%   filt_img - image filtered based on wavelength range specified

filt_img = zeros(size(img));
xyz = rgb2xyz(img);
X = xyz(:,:,1)./sum(xyz,3);
Y = xyz(:,:,2)./sum(xyz,3);

wav_val = chart(:,1);
cie_val = chart(:,2:4);
ref_theta = atan2( cie_val(:,2)./sum(cie_val,2) - 0.33, cie_val(:,1)./sum(cie_val,2) - 0.33);

fprintf('Filtering Image based on wavelength range (%d - %d):\n', wave_L, wave_R);

count = 0;

for i = 1:size(img,1),
    for j = 1:size(img,2),
         
        pix_theta = atan2( Y(i,j) - 0.33 , X(i,j) - 0.33 );  
        [~,idx] = min( abs(pix_theta - ref_theta) );
        
        if( wav_val(idx) >= wave_L && wav_val(idx) <= wave_R),
            filt_img(i,j,:) = img(i,j,:);
        end
        
        if( mod(count,5000)==1 ), 
            fprintf('.');
        end
        count = count + 1;
        
    end
end

fprintf('\n');
disp('Filtering complete');
imshow(uint8(filt_img));
title(['Wavelength range ' num2str(wave_L) 'nm - ' num2str(wave_R) 'nm.']);
end

