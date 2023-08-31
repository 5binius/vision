im = imread('lena_grey.bmp');

%ratation degree
degree = 110;
rad = degtorad(degree);
scale_value= 0.6;

%x,y coordinate
[y,x] = meshgrid(1:size(im,2), 1:size(im,1));

%Find the midpoint
midx = ceil((size(im,1))/2);
midy = ceil((size(im,2))/2);

%scaling
scale=[scale_value,0,0; 0,scale_value,0; 0,0,1]; 
%translation
tran1=[1, 0 , -midx; 0 , 1, -midy; 0, 0 ,1];  
tran2=[1, 0 , midx; 0 , 1, midy; 0, 0 ,1];    
%rotation
rot=[cos(rad),-sin(rad),0; sin(rad), cos(rad),0; 0,0,1];

%combined linear transformation array
eq=tran2*rot*tran1*scale;

x_r=eq(1,1).*x+eq(1,2).*y+eq(1,3);
y_r=eq(2,1).*x+eq(2,2).*y+eq(2,3);

x_r=round(x_r);
y_r=round(y_r);
maxsize= ceil((cos((pi/4)-rad))*scale_value*512*sqrt(2));


%output image size
if min(x_r(:))<0
outsize_x= max(x_r(:))+abs(min(x_r(:)))+1;
x_r=x_r+abs(min(x_r(:)))+1;
else
    outsize_x=max(x_r(:))-min(x_r(:));
end

if min(y_r(:))<0
outsize_y= max(y_r(:))+abs(min(y_r(:)))+1;
y_r=y_r+abs(min(y_r(:)))+1;
else
    outsize_y=max(y_r(:))-min(y_r(:));
end

out = zeros(maxsize);
out=uint8(out);
 
y_r(y_r==0) = 1;
x_r(x_r==0) = 1;

%forward mapping
for j = 1:size(im,1)
    for i = 1:size(im,2)

        out(x_r(j,i),y_r(j,i)) = im(j,i);

    end 
end

imwrite(out,'forward_mapping_1.bmp','bmp');
imshow(im);
pause
imshow(uint8(out));



