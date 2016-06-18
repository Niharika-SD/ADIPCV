function J = region_Grow(image, indexX,indexY)

initial_Position(:,1) = indexX;
initial_Position(:,2) = indexY;

%threshold
thresVal = double((max(image(:)) - min(image(:)))) * 0.05;

maxDist = inf;
[num_Row, num_Col] = size(image);

% initial pixel value
reg_Val = double(image(initial_Position(1), initial_Position(2)));

% preallocation
J = zeros(num_Row, num_Col);

% adding initial pixel to queue

%%%REGION GROWING ALGORITHM
for num = 1:length(indexX)
    queue = [initial_Position(num,1), initial_Position(num,2)];
    while size(queue, 1)
      % the first queue position determines the new values
      x_v = queue(1,1);
      y_v = queue(1,2);  

      %  deleting the first queue position
      queue(1,:) = [];

      % check the neighbors for the current position
      for i = -1:1
        for j = -1:1               
            if x_v+i > 0  &&  x_v+i <= num_Row &&...          % checking the x-bounds
               y_v+j > 0  &&  y_v+j <= num_Col &&...          % checking the y-bounds         
               any([i, j])       &&...      % for i/j/k of (0/0/0) redundancy!
               ~J(x_v+i, y_v+j) &&...          % checking for pixelposition already set
               sqrt( (x_v+i-initial_Position(num,1))^2 +...
                     (y_v+j-initial_Position(num,2))^2 ) < maxDist &&...   % checking within distance?
               image(x_v+i, y_v+j) <= (reg_Val + thresVal) &&...%checking for within range of threshold or not
               image(x_v+i, y_v+j) >= (reg_Val - thresVal) 

               % current pixel is true, if all properties are fullfilled
               J(x_v+i, y_v+j) = true; 

               % add the current pixel to the computation queue (recursive)
               queue(end+1,:) = [x_v+i, y_v+j];   
           end               

        end  
      end
    end
end
%hole filling
    J(:,:) = imfill(J(:,:), 'holes');
end