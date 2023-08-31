in=imread('house_grey.bmp');
[height,width]=size(in);
out= zeros(height,width);

%gaussian filter

f_size=5;   %filter의 크기
sigma=8;     %variance 값
f_cnt=(f_size-1)/2;
h=double(zeros(f_size));   %filter

%zero padding
out= zeros(height,width);
in_p= zeros(height+f_size-1,width+f_size-1);
in_p(f_cnt+1:height+f_cnt,f_cnt+1:width+f_cnt)=in;
 
%filter 값 설정
for b=1:f_size
     for a=1:f_size
        h(b,a)=(1/(2*pi*(sigma.^2)))*exp(-((a-f_cnt-1).^2+(b-f_cnt-1).^2)/(2*(sigma.^2)));
        
      end
end
h= h/sum(h(:));  %normalize

%gaussian_filter 적용
for y= f_cnt+1:height+f_cnt  
    for x=f_cnt+1:width+f_cnt
        temp=in_p(y-f_cnt:y+f_cnt,x-f_cnt:x+f_cnt).*h;
        out(y-f_cnt,x-f_cnt)= sum(temp(:)); 
    end
end
    
in=uint8(out);

in=double(in);
out=zeros(height,width);

%laplacian 연산자
L=[0 1 0; 1 -4 1; 0 1 0];

%laplacian 적용
for y=1:size(in,1)-2
    for x=1:size(in,2)-2
        out(y+1,x+1)=sum(sum(L.*in(y:y+2,x:x+2)));       
    end
end

e=zeros(1,4);
e_1=zeros(1,4);
e_2=zeros(1,4);
e_3=zeros(1,4);
tmp=zeros(height,width);

T=2.5; % threshold
max_t= 0; 

for y=2:size(in,1)-2
    for x=2:size(in,2)-2
        
        cnt=0;  % 부호가 다른 쌍의 갯수 저장
   
        e_1= [out(y-1,x-1), out(y-1,x+1),out(y-1,x), out(y,x-1)];
        e_2= [out(y+1,x+1), out(y+1,x-1),out(y+1,x), out(y,x+1)];
        
        e_3=e_1.*e_2;  %부호 확인
        e=abs(e_1-e_2); %픽셀값의 차이
      
        for i=1:4;
            if e_3(1,i) < 0 && e(1,i)> T
                if max_t<e(1,i);
                    max_t=e(1,i);
                end
             cnt=cnt+1;
            end
        end
        if cnt>1 
             tmp(y,x)=0;
        else tmp(y,x)=1;
        end
       
    end
end

 imshow(tmp);
 imwrite(tmp,'house_LoG_5.bmp','bmp');



