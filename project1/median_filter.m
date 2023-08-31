in=imread('lena_i_n_4.bmp');
[height,width]=size(in);
%denosing
%median filter
f_size=9;   %filter의 크기 f_sziexf_size
f_cnt=(f_size-1)/2;
%zero padding
out= zeros(height,width);
in_p= zeros(height+f_size-1,width+f_size-1);
in_p(f_cnt+1:height+f_cnt,f_cnt+1:width+f_cnt)=in;
 
%filter 적용
for y= f_cnt+1:height+f_cnt
    for x=f_cnt+1:width+f_cnt
        temp=in_p(y-f_cnt:y+f_cnt,x-f_cnt:x+f_cnt);
        temp_sort=sort(temp(:)); %2D matrix를 1D matrix로 변환후 sorting
        out(y-f_cnt,x-f_cnt)=temp_sort(round((f_size^2)/2));  %sorting되 값중 중간값을 적용
    end
end
  out=uint8(out);
  imshow(out);
  imwrite(out,'lena_m_f_6.bmp','bmp');
  

  
  
       
        
