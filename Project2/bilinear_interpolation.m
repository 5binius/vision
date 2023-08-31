im = imread('lena_grey.bmp');

%ratation degree
degree = 30;
rad = degtorad(degree);
scale_value= 1.3;

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
inv_eq=inv(eq);

x_r=eq(1,1).*x+eq(1,2).*y+eq(1,3);
y_r=eq(2,1).*x+eq(2,2).*y+eq(2,3);

x_temp=x_r;
y_temp=y_r;

x_r=round(x_r);
y_r=round(y_r);

%output image size
if min(x_r(:))<0
outsize_x= max(x_r(:))+abs(min(x_r(:)))+1;
x_r=x_r+abs(min(x_r(:)))+1;
x_temp=x_temp+abs(min(x_temp(:)))+1;
else
    outsize_x=max(x_r(:))-min(x_r(:));
end

if min(y_r(:))<0
outsize_y= max(y_r(:))+abs(min(y_r(:)))+1;
y_r=y_r+abs(min(y_r(:)))+1;
y_temp=y_temp+abs(min(y_temp(:)))+1;
else
    outsize_y=max(y_r(:))-min(y_r(:));
end

out = zeros([outsize_y outsize_x]);
out=uint8(out);
 

y_r(y_r==0) = 1;
x_r(x_r==0) = 1;

%forward mapping
for j = 1:size(im,1)
    for i = 1:size(im,2)

        out(x_r(j,i),y_r(j,i)) = im(j,i);

    end 
end


out_t=out;
%bilinear interpolation
for j = 2:size(out,1)-1
    for i = 2:size(out,2)-1
        temp = out(j-1:j+1,i-1:i+1);
       temp=double(temp); 
        if(temp(5)==0&&sum(temp(:))~=0)
            p = find(temp~=0);
            
            [x1,x2]=find(x_r(j,i)==i);
            [y1,y2]=find(y_r(j,i)==j);
          
          
           intp_x1=(x_t-(i-1))*temp(1,3)+(i+1-x_t)*temp(1,1);
           intp_x2=(x_t-(i-1))*temp(3,3)+(i+1-x_t)*temp(3,1);
           
           intp=(y_t-(j-1))*intp_x2+(j+1-y_t)*intp_x1;
           out_t(j,i)=round(intp);

            end
        end
    end
end

out=out_t;

imwrite(out,'bilinear_intp_1.bmp','bmp');
imshow(im);
pause
imshow(uint8(out));

       