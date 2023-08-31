in=imread('lena_i_n_4.bmp');
[height,width]=size(in);
out= zeros(height,width);

%denosing
%gaussian filter

f_size=13;   %filter의 크기
sigma=3;     %variance 값
f_cnt=(f_size-1)/2;
h=double(zeros(f_size));   %filter

%zero padding
out= zeros(height,width);
in_p= zeros(height+f_size-1,width+f_size-1);
in_p(f_cnt+1:height+f_cnt,f_cnt+1:width+f_cnt)=in;
 
%filter 값 설정
for b=1:f_size
     for a=1:f_size
        h(b,a)=(1/(2*pi*sigma*sigma))*exp(-((a-f_cnt-1).^2+(b-f_cnt-1).^2)/(2*(sigma.^2)));
        
      end
end

 h= h/sum(h(:)); %normalize
 
%filter 적용
for y= f_cnt+1:height+f_cnt  
    for x=f_cnt+1:width+f_cnt
        temp=in_p(y-f_cnt:y+f_cnt,x-f_cnt:x+f_cnt).*h;
        out(y-f_cnt,x-f_cnt)= sum(temp(:)); 
        if out(y-f_cnt,x-f_cnt)>255;
            out(y-f_cnt,x-f_cnt)=255;
        end
    end
end
    
out=uint8(out);
  imshow(out);
  imwrite(out,'lena_g_f_9.bmp','bmp');
  

  
  
       
        
