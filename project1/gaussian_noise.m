in=imread('lena_grey.bmp');
[height,width]=size(in);
out= zeros(height,width);
out=in;

%gaussian noise 생성
v=25; %표준편차
g=v*randn(512);  
out=double(out); 
out=out + g;

out=uint8(out);
  imshow(out);
  imwrite(out,'lena_g_n_5.bmp','bmp');
  

  
  
       
        
