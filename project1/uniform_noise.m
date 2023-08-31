in=imread('lena_grey.bmp');
[height,width]=size(in);
out= zeros(height,width);

%uniform noise 생성
v=25; %표준편차
g=v*rand(512);
out= double(in)+g;
        
out=uint8(out);
  imshow(out);
  imwrite(out,'lena_uniform_n_3.bmp','bmp');
  

  
  
       
        
