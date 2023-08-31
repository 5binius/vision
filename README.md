# 영상처리

한 줄 소개: matlab 이용 영상처리 알고리즘 설계

Skills: C, C++, matlab

팀 구성: 개인 과제

### 🔗 Link

**Source**

[https://github.com/5binius/vision](https://github.com/5binius/vision)

## ✍️ 학습 목표

- 영상의 입출력 및 처리과정의 이론적 배경 및 실습
- 주요 영상처리 알고리즘 학습
- 실제 프로그래밍을 통해 구현 실습하여 분석하는 능력 습득

## 🛠 사용 기술 및 라이브러리

- C, C++
- MATLAB

## 🖥 요약

1. Denoising
    1. gaussian filter
    2. bileteral filter
    3. median filter
    4. subjective/ objective (PSNR) measurements
2. Edge Detection
    1. sobel, Prewitt edge detector
    2. LoG filter
3. Transformation
    1. rotation
    2. scaling
    3. translation
4. Interpolation
    1. Nearest neighborhood
    2. bilinear
5. Corner Detection
    1. Moravec
    2. Harris
    3. SUSAN
6. Mean shift
    1. cluster
7. Multi-Layer perceptron
    1. feed-forward MLP
    2. back propagation



# **project 2**

# 목표

- corner detection 알고리즘 탐구
- Moravec/ Harris/ SUSAN 알고리즘을 각각 구현 후 차이점 비교

![Harris corner detection](https://github.com/5binius/vision/blob/main/Untitled.png?raw=true)

Harris corner detection

# 구현/ 결과

```matlab

//Harris corner Detection 

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
```

![Untitled]( https://github.com/5binius/vision/blob/main/Untitled%202.png?raw=true)

![Untitled](https://github.com/5binius/vision/blob/main/Untitled%201.png?raw=true)


# 고찰

moravec 방식은 노이즈에 약하고 회전에도 약하다. 반면에 harris 방식은 gaussian mask를 적용시켜 노이즈에 대비할 수 있고, rotation invariant하다. 위의 결과를 비교해보면 moravec보다 harris의 경우 실제 사람이 판단했을 때의 코너와 비슷하게 검출되었다.
연산의 복잡도를 비교해보면 moravec의 경우 모든 픽셀에 대해 s-map을 생성해야한다. 이 때, 네 방향에 관해서 최솟값을 구한다. 그러므로 mask size ^2 x 4 번 연산 후 이중 최소값을 계산해야한다. 이를 이미지의 크기만큼 반복한다.
harris의 경우 x, y 방향으로 각각 미분하고 이를 가우시안 연산해야한다. 그 후에 검출식을 계산 후 threshold와 비교해야한다. moravec보다 복잡도가 높다.
susan 의 경우 주변 픽셀값의 차이를 구하고 그것의 개수를 계산하여 threshold와 비교하므로 복잡도는 위의 두 경우 보다 낮다.

