im = imread('lena_grey.bmp');


[height,width]=size(im);
im=double(im);
out=im;

mask=[0 0 1 1 1 0 0; 0 1 1 1 1 1 0; 1 1 1 1 1 1 1;1 1 1 1 1 1 1;1 1 1 1 1 1 1; 0 1 1 1 1 1 0;0 0 1 1 1 0 0];

mask_size=37;
t1= 50;
t2= 1.0;

for j=4:size(im,1)-4
    for i=4;size(im,2)-4
        temp=im(j-3:j+3,i-3:i+3);
       % temp=temp.*mask;
        temp=temp-im(j,i);
        for y=1:7
            for x=1:7
                 if abs(temp(y,x))<=t1
                    temp(y,x)=1;
                 else
                    temp(y,x)=0;
                 end
            end
        end
        temp=temp.*mask;
        us_area=sum(temp(:));
        us_area=double(us_area);
        if (us_area/mask_size) <=t2;
            out(j,i)=255;
        else
            out(j,i)=im(j,i);
        end
    end
end


imwrite(out,'susan_1.bmp','bmp');
imshow(uint8(out));

        