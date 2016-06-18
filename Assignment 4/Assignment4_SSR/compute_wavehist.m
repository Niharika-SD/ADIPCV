function [ norm_hist ] = compute_wavehist( img_name, chart, n_bins, doResize, doPlot )
% Computes a normalized histogram in wavelength space
% Input Params:
%   img - source imageange
%   Chart - Wavelength CIE-chart stored in the following format for each
%   row: [ Wavelength X Y Z ] 
%   n_bins - Number of Histogram Bins
%   doPlot - Plots histogram if value if set to True
% Output:
%   norm_hist: Normalised Histogram in Wavelength Space

img = imread(img_name);
if doResize,
    img = imresize(img,0.3);
end

xyz = rgb2xyz(img);
X = xyz(:,:,1)./sum(xyz,3);
Y = xyz(:,:,2)./sum(xyz,3);

wav_val = chart(:,1);
cie_val = chart(:,2:4);
ref_theta = atan2( cie_val(:,2)./sum(cie_val,2) - 0.33, cie_val(:,1)./sum(cie_val,2) - 0.33);

hist = zeros(n_bins,1);
labels = linspace(min(wav_val), max(wav_val), n_bins+1);

for i = 1:size(img,1),
    for j = 1:size(img,2),
        pix_theta = atan2( Y(i,j) - 0.33 , X(i,j) - 0.33 );  
        [~,idx] = min( abs(pix_theta - ref_theta) );
        for k = n_bins:-1:1,
            if wav_val(idx) >= labels(k),
                 hist(k) = hist(k) + 1;
                 break
            end
        end      
    end
end

norm_hist = hist/sum(hist);

if doPlot,
    bar(norm_hist);    
    title(['Histogram for ' img_name]);
end