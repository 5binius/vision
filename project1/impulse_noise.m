in=imread('lena_grey.bmp');
[height,width]=size(in);
out= in;


%impulse noise ����
p= 0.3;  %0~1������ Ȯ����
cnt=int32(round(p*height*width));  %noise �� ������ �ȼ� ��

s=zeros(2,cnt);
s=randi([1,width],2,cnt);  %noise�� ��ġ�� s�� ����

%s�� ����� ��ġ�� noise ����
for x= 1:cnt/2
      out(s(2,x),s(1,x)) = 0;
end
 
  for y=cnt/2+1:cnt
      out(s(2,y),s(1,y))= 255;
  end
     
out=uint8(out);
  imshow(out);
   title('p=0.1');
  imwrite(out,'lena_i_n_4.bmp','bmp');
  

  
  
       
        
