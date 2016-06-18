function [x,y]= characterise_topology(K,H,Pmin,Pmax)

[m,n] = size(K);
x = zeros(size(K));
y = zeros(size(K));

for i =1:m
    for j= 1:n

        if(K(i,j)<0)
            if(H(i,j)<0)
                x(i,j) = 1;
            elseif(H(i,j)==0)
                x(i,j) = 4;
            else
                x(i,j) = 7;
            end
        elseif(K(i,j)==0)
            if(H(i,j)<0)
                x(i,j) = 2;
            elseif(H(i,j)==0)
                x(i,j) = 5;
            else
                x(i,j) = 8;
            end
        else
           if(H(i,j)<0)
                x(i,j) = 3;
            elseif(H(i,j)==0)
                x(i,j) = 6;
            else
                x(i,j) = 9;
           end            
        end
    end
    
    if(Pmax(i,j)<0)
            if(Pmin(i,j)<0)
                y(i,j) = 1;
            elseif(Pmin(i,j)==0)
                y(i,j) = 4;
            else
                y(i,j) = 7;
            end
        elseif(Pmax(i,j)==0)
            if(Pmin(i,j)<0)
                y(i,j) = 2;
            elseif(Pmin(i,j)==0)
                y(i,j) = 5;
            else
                y(i,j) = 8;
            end
        else
           if(Pmin(i,j)<0)
                y(i,j) = 3;
            elseif(Pmin(i,j)==0)
                y(i,j) = 6;
            else
                y(i,j) = 9;
           end            
    end
end
end
