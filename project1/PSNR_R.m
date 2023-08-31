in=imread('lena_grey.bmp');
original=imread('lena_g_f_9.bmp');
[height,width]=size(in);
out= zeros(height,width);

h=double(zeros(height,width));   %filter

%MSE
h= original-in;
h=h.*h;
MSE=sum(h(:))/(height*width);

%PSNR
psnr= 10*log(255*255/MSE);

  
  
       
        
