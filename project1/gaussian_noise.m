in=imread('lena_grey.bmp');
[height,width]=size(in);
out= zeros(height,width);
out=in;

%gaussian noise ����
v=25; %ǥ������
g=v*randn(512);  
out=double(out); 
out=out + g;

out=uint8(out);
  imshow(out);
  imwrite(out,'lena_g_n_5.bmp','bmp');
  

  
  
       
        
