function response=harris_corners(image)
window_size=3;
k=0.04;
border=20;
% verison2
% k=0.04;
% border=20;
%转化为灰度图
if length(size(image))==3
    image = rgb2gray(double(image)/255);
end

%初始化矩阵
[H,W]=size(image);
E=zeros(H,W);

%sobel算子
sobelx=[-1 0 1;-2 0 2;-1 0 1];
sobely=[-1 -2 -1;0 0 0;1 2 1];

%计算梯度值
Gx=conv2(image,sobelx,'same');
Gy=conv2(image,sobely,'same');
window=ones(window_size,window_size);                    
A=conv2(Gx.*Gx,window,'same');
B=conv2(Gx.*Gy,window,'same');
C=conv2(Gy.*Gy,window,'same');

%计算响应值
for i=1:H
    for j=1:W
        M=[A(i,j),B(i,j);B(i,j),C(i,j)];
        E(i,j)=det(M)-k*(trace(M)^2);
    end
end
Emax=max(E(:));
t=Emax*0.01;
E=padarray(E,[1 1],'both');

%使用阈值过滤角点
for i=2:H+1
    for j=2:W+1
        if E(i,j)<t
            E(i,j)=0;
        end
    end
end

%非极大值抑制
for i=2:H+1
    for j=2:W+1
        if E(i,j)~=0
            neighbors=get_neighbors(E,i,j);
            if E(i,j)<max(neighbors(:))
                E(i,j)=0;
            end
        end
    end
end

%剔除无效角点
response=E(2:H+1,2:W+1);
response(1:border,:)=0;
response(:,1:border)=0;
response(H-border+1:H,:)=0;
response(:,W-border+1:W)=0;

response(response~=0)=1;
end

%返回该点相邻的坐标点
function neighbors=get_neighbors(m,x,y)
neighbors =[m(x-1,y-1),m(x-1,y),m(x-1,y+1),m(x,y-1),m(x,y+1),m(x+1,y-1),m(x+1,y),m(x+1,y+1)];
end

