
d= 10      %length(filepaths); % input node 개수
t=zeros(10,1)  %예상 결과값 벡터
p=40; % number of hidden layer
m=10; %number of ouput node
l_r=0.5;
pp=40;
u=rand(d+1,p); %input-hidden layer weight
v=rand(p+1,m); %hidden-output layer weight

z_sum=rand(pp+1,1);
o=zeros(10,1);
o_sum=zeros(10,1);


train_img_dir = 'Train_img/';
train_lab_dir = 'Train_lab/';

% train_img_dir = 'Test_img/';
% train_lab_dir = 'Test_lab/';

% FIle I/O
filepaths = dir(fullfile(train_img_dir,'*.bmp'));
fp = fopen([train_lab_dir 'label.txt']);

% Read one image and one label from folder
for i = 1 : 1000
    
    
   %length(filepaths)
    im_raw = imread(fullfile(train_img_dir,filepaths(i).name)); % one image
    
    im_lab = str2num(fgetl(fp)); % one label
%     imshow(im_raw); % display image
%     fprintf('%d \n', im_lab); % display label (commnad line)
    %pause



    im_raw=im2bw(im_raw);
    x=im_raw(:);  %input vector
    t(im_lab+1)=1; %expected output vector



%feed forward MLP




%은닉층의 j번째 노드
for j=1:pp
    for i=1:d
        temp= x(i)*u(i+1,j);
        z_sum(j)=temp+z_sum(j);
    end
    z_sum(j)=z_sum(j)+u(1,j);
    [z(j),tau_d_z(j)]=tau(z_sum(j),0.5);

end


%출력층의 k번째 노드
for k=1:m
    for j=1:pp
        temp= z(j)*v(j+1,k);
        z_sum(k)=temp+z_sum(k);
    end
    
    o_sum(k)=o_sum(k)+v(1,k);
    [o(k),tau_d_o(k)]=tau(o_sum(k),0.5);
   
end
 [~,t]=max(o(:));
    o=zeros(10);
    o(t+1)=1;


%train cell

delta=(t-o).*tau_d_o;

for k=1:m
    for j=1:pp+1
        delta_v(j,k)=l_r*delta(k)*z(k);
    end
end

for j=1:pp
ww(j)=tau_d_z(j)*sum(sum(delta.*v(j,:)));

end

for i=1:d+1
    for j=1:pp
        delta_u(i,j)=l_r*ww(j)*x(i);
    end
end

v=delta_v+v;
u=delta_u+u;


end

train_img_dir = 'Test_img/';
train_lab_dir = 'Test_lab/';

% FIle I/O
filepaths = dir(fullfile(train_img_dir,'*.bmp'));
fp = fopen([train_lab_dir 'label.txt']);

% Read one image and one label from folder
for i = 1 : 10%length(filepaths)
    im_raw = imread(fullfile(train_img_dir,filepaths(i).name)); % one image
    
    im_lab = str2num(fgetl(fp)); % one label
  imshow(im_raw); % display image
     fprintf('lab:%d ', im_lab); % display label (commnad line)
%     pause



    im_raw=im2bw(im_raw);
    x=im_raw(:);  %input vector
    t(im_lab+1)=1; %expected output vector


%feed forward MLP

%은닉층의 j번째 노드
for j=1:pp
    for i=1:d
        temp= x(i)*u(i+1,j);
        z_sum(j)=temp+z_sum(j);
    end
    z_sum(j)=z_sum(j)+u(1,j);
    [z(j),tau_d_z(j)]=tau(z_sum(j),0.5);

end


%출력층의 k번째 노드
for k=1:m
    for j=1:pp
        temp= z(j)*v(j+1,k);
        z_sum(k)=temp+z_sum(k);
    end
    
    o_sum(k)=o_sum(k)+v(1,k);
    [o(k),tau_d_o(k)]=tau(o_sum(k),0.5);
   
   
end
 t=max(o(k));
    o=zeros(10);
    o(t+1)=1;
    fprintf("t: %d\n",t+1);
    
end