function hgram =create_wavelength_hist(input,M_norm)

[m,n,p] = size(input);
hgram = zeros(1,471);

for i=1:m
    for j = 1:n
        %computing the angle at the point
        angle = atan2((input(i,j,2)-(1/3)),(input(i,j,1)-1/3))*180/pi;
        %initialisation
        hist_val = 1;
        
        for k = 1:1:470
            %assigning bins
            if (abs(angle-M_norm(hist_val,5))>abs(angle-M_norm(k+1,5)))
              
                  hist_val= (k+1);
                  
            end
            
        end    
        hgram(hist_val)=hgram(hist_val)+1;
    end
end
%normalising
hgram=hgram/(m*n);

end