

im=imread('128.bmp');

x=zeros(size(im,1)*size(im,2),3);
m_y=zeros(size(im,1)*size(im,2),3);
y=zeros(size(im,1)*size(im,2),3);
v=zeros(size(im,1)*size(im,2),3);

out=im;

h=4; %filter size
threshold=10;
t=1;
for j=1:size(im,1)
    for b=1:size(im,2)

    x(t,:)=[im(j,b,1),im(j,b,2),im(j,b,3)];
% 
%     R=im(j,i,1);
%     G=im(j,i,2);
%     B=im(j,i,3);
% 
%     H(j,i)= acos((2*R-G_B))/2*root(sqr(R-G)+(R-B)(G-B)));
%   
%     if B>=G
%         H(j,i)=360-H(j,i);  
%     end
% 
%     S(j,i)=(1-3/(R+G+B)) * min(R,G,B);
% 
%     I=(R+G+B)/3;
% 
%     x(t,:)=[H(j,i),S(j,i),L(j,i)];

% x(t,:)=[im(j,i,1),im(j,i,2),im(j,i,3),i,j];
    t=t+1;

    end
end

%filter

m_y(1,:)=0;
for s=h+1:size(im,2)*size(im,1)

    y(1,:)=x(s,:);
    t=1;
   for t=1:size(im,2)*size(im,1)-2*h-1
       
        ii=1;
       for b= t:t+2*h+1
        
             temp= abs((x(b,:)-y(t,:))/h);
             nn=temp.*temp;
             
              if    sum(nn)/3<=1
                     k(ii)=1;
              else
                     k(ii)=0;
              end
     
             m_y(t,:)=m_y(t,:)+abs((x(b,:)-y(t,:)))*k(ii);
          
            ii=ii+1;
            
         end
    
    m_y(t,:)=m_y(t,:)/sum(k(:));
     y(t+1,:)=y(t,:)+m_y(t,:);
    tempp=sum(m_y(t).*m_y(t))/3;

    if tempp<threshold
         break;
    end
   end
  
   fj=ceil(s/128);
   fi=s-128*(fj-1);
   out(fj,fi+1)=x(s);
    %v(s,:)=y(t+1,:);
end

imshow(out);

