in=imread('lena_g_n_5.bmp');
[height,width]=size(in);
out= zeros(height,width);

%denosing
%gaussian filter

f_size=19;   %filter의 크기
sigma_s=3;     %variance 값
f_cnt=(f_size-1)/2;
sigma_r=30;
weights_s=double(zeros(f_size)); 
weights_r=double(zeros(f_size));%filter
h_r=double(zeros(f_size));

%zero padding
out= zeros(height,width);
in_p= zeros(height+f_size-1,width+f_size-1);
in_p(f_cnt+1:height+f_cnt,f_cnt+1:width+f_cnt)=in;
 
%filter 값 설정
for b=1:f_size
     for a=1:f_size
        weights_s(b,a)=(1/(2*pi*(sigma_s.^2)))*exp(-((a-f_cnt-1).^2+(b-f_cnt-1).^2)/(2*(sigma_s.^2)));
        
      end
end
weights_s= weights_s/ sum(weights_s(:)); % normalize

%filter 적용
for y= f_cnt+1:height+f_cnt  
    for x=f_cnt+1:width+f_cnt
        temp=in_p(y-f_cnt:y+f_cnt,x-f_cnt:x+f_cnt);
       
        %range information
        weights_r=exp(-((temp-(double(in(y-f_cnt,x-f_cnt)).*ones(f_size))).^2)/(2*sigma_r*sigma_r));
        weights= weights_s.*weights_r+0.0001;
        weights_f=weights/sum(weights(:));
        result=double(in(y-f_cnt,x-f_cnt)).*weights_f;
        out(y-f_cnt,x-f_cnt)= sum(result(:)); 
    end
end
    
out=uint8(out);
  imshow(out);
  imwrite(out,'lena_b_f_2.bmp','bmp');
  

  
  
       
        
