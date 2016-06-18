%% PART 1 Curvature calculation

A=imread('0.png');
[m,n] = size(A);
range_data = zeros(m*n,3);

%initialising the variables storing curvature information
Pmin = zeros(4,m,n); % K1 principal curvature
Pmax = zeros(4,m,n); % K2 principal curvature
K = zeros(4,m,n);  % Gaussian curvature
H = zeros(4,m,n); % mean curvature

for k= 1:4
    
 %read the image   
str = strcat(num2str(k),'.png');
A =imread(str);

for i= 1:m
    for j=1:n
         %transform into range data (X,Y,Z)
        range_data((i-1)*m+j,:,:,:) = [i,j,A(i,j)];
        
    end
end

range_data =range_data' ;

X = reshape(range_data(1,:,:),m,n);
Y= reshape(range_data(2,:,:),m,n);
Z = reshape(range_data(3,:,:),m,n);

%calculating the curvatures
[a,b,c,d] = calculate_curvatures(X,Y,Z);

K(k,:,:)= a;
H(k,:,:)=b;
Pmax(k,:,:)=d;
Pmin(k,:,:)=c;
clear range_data;
range_data = zeros(m*n,3);
end

%% PART 2 Local Topology Characterisation

x= zeros(4,m,n);
y= zeros(4,m,n);
for i= 1:4
[x(i,:,:),y(i,:,:)]= characterise_topology(K(i,:,:),H(i,:,:),Pmin(i,:,:),Pmax(i,:,:));
end

