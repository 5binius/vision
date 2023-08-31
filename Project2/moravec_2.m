im = imread('test_grey.bmp');

%im=rgb2gray(im);
out=im;

msize=3;
msize_f=floor(msize/2);

for j=msize_f+2:size(im,1)-msize_f-1
for i=msize_f+2:size(im,2)-msize_f-1
    for v=-1:1
        for u=-1:1
            temp= im(j+v-msize_f:j+v+msize_f,i+u-msize_f:i+u+msize_f)-im(j-msize_f:j+msize_f,i-msize_f:i+msize_f);
            temp=temp.*temp;
            s(v+2,u+2)=sum(temp(:));
           
        end
    end
    
    C=[s(1,2),s(2,1),s(2,3),s(3,2)];
    C=min(C)/(msize*msize);
 
            if C>25
                out(j,i)=255;
            else
                out(j,i)=im(j,i);
            end
end
end

imwrite(out,'moravec_8.bmp','bmp')
imshow(uint8(out));

