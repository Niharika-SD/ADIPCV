function [matchLoc1,matchLoc2] = km_siftMatch(image1, image2)

% Find SIFT keypoints for each image
[destination1, location1] = sift(image1);
[desination2, location2] = sift(image2);
distRatio = 0.6;   

% For each descriptor in the first image, select its match to second image.
des2t = desination2';                          % Precompute matrix transpose
matchTable = zeros(1,size(destination1,1));
for i = 1 : size(destination1,1)
   dotprods = destination1(i,:) * des2t;        % Computes vector of dot products
   [vals,indx] = sort(acos(dotprods));  % Take inverse cosine and sort results

   % Check if nearest neighbor has angle less than distRatio times 2nd.
   if (vals(1) < distRatio * vals(2))
      matchTable(i) = indx(1);
   else
      matchTable(i) = 0;
   end
end

num = sum(matchTable > 0);
fprintf('Found %d matches.\n', num);

idx1 = find(matchTable);
idx2 = matchTable(idx1);
x1 = location1(idx1,2);
x2 = location2(idx2,2);
y1 = location1(idx1,1);
y2 = location2(idx2,1);

matchLoc1 = [x1,y1];
matchLoc2 = [x2,y2];

end