im = imread('test_grey.bmp');

[height,width]=size(im);
im=double(im);
out=im;

%filter 값 설정
f_size=3;
f_cnt=floor(f_size/2);
sigma=2.0;

for b=1:f_size
     for a=1:f_size
        h(b,a)=(1/(2*pi*(sigma^2)))*exp(-((a-f_cnt-1)^2+(b-f_cnt-1)^2)/(2*(sigma^2)));
        
      end
end

 h= h/sum(h(:)); %normalize

 dx_f=[-1,0,1;-1, 0, 1 ; -1,0,1];
 dy_f=[-1,-1,-1; 0 0 0 ;1 1 1];
 dx=zeros(height,width);
 dy=zeros(height,width);
 
 %x, y방향으로 각각 1차 미분
 for y= 1:height-2  
    for x=1:width-2
     dx(y+1,x+1)=sum(sum(dx_f.*im(y:y+2,x:x+2)));
     dy(y+1,x+1)=sum(sum(dy_f.*im(y:y+2,x:x+2)));
       
    end
 end

dx2=dx.*dx;  
dy2=dy.*dy;
dydx=dy.*dx;
 
%parameter 설정
k=0.04;
T=900.0;
 


% dy_f=[-1;0;1];
% temp1=im(:,1:width-1);
% temp2= im(:,2:width);


%dx=zeros(height,width);
% dx(:,2:width)=temp2-temp1;
% temp1=im(1:height-1,:);
% temp2= im(2:height,:);
%dy=zeros(height,width);
% dy(2:height,:)=temp2-temp1;



for y=2:size(im,1)-1
    for x=2:size(im,2)-1
        
        %gaussian filter적용
       
        temp=dy2(y-f_cnt:y+f_cnt,x-f_cnt:x+f_cnt).*h;
        dy_g= sum(temp(:)); 
    
      
        temp=dx2(y-f_cnt:y+f_cnt,x-f_cnt:x+f_cnt).*h;
        dx_g= sum(temp(:)); 
        
        temp=dydx(y-f_cnt:y+f_cnt,x-f_cnt:x+f_cnt).*h;
        dxdy_g=sum(temp(:));
        
      %corner 검출식
        C=(dx_g.*dy_g-dxdy_g^2)./(dx_g+dy_g);
       % C=det(A)-k*(trace(A)^2);
        
        if C>T
            out(y,x)=255;
        else
            out(y,x,:)=im(y,x,:);
        end
        
    end
end

imwrite(out,'harris_3.bmp','bmp')
imshow(uint8(out));
