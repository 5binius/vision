in=imread('house_grey.bmp');

%Filter Masks 
%sobel
Fx=[-1 0 1;-2 0 2; -1 0 1];
Fy=[-1 -2 -1;0 0 0; 1 2 1];

%prewitt
% Fx=[-1 0 1; -1 0 1; -1 0 1];
% Fy=[-1 -1 -1; 0 0 0; 1 1 1];
in=double(in);

[height,width]=size(in);
out= zeros(height,width);
for y=1:size(in,1)-2

    for x=1:size(in,2)-2

        %Gradient operations

        Gx=sum(sum(Fx.*in(y:y+2,x:x+2)));
        Gy=sum(sum(Fy.*in(y:y+2,x:x+2)));

        %Magnitude of vector
         out(y+1,x+1)=sqrt(Gx.^2+Gy.^2);
    end

end

%out=uint8(out);
% imshow(out);

%threshold value 

Threshold=230;
for y=1:size(in,1)
    for x=1:size(in,2)

if out(y,x)< Threshold;
    tmp(y,x)=0;
else tmp(y,x)=1;
    
end
    end
end

imshow(tmp);
imwrite(tmp,'house_e_sobel_3.bmp','bmp');



