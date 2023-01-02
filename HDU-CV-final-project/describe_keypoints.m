function [keypoints,descriptors]=describe_keypoints(image,response,patch_scale)

%转化为灰度图
if length(size(image))==3
    image = rgb2gray(double(image)/255);
end

%角点图坐标
[x,y]=find(response==1);
keypoints=zeros(length(x),2);
keypoints(:,1)=x;
keypoints(:,2)=y;

%初始化描述向量矩阵
ps=floor(patch_scale*0.5);
descriptors=zeros(length(x),(ps*2)^2);

%计算每个角点的特征向量
for i=1:length(keypoints)
    tempx=keypoints(i,1);%角点x坐标
    tempy=keypoints(i,2);%角点y坐标
    patch1=image(tempx-ps:tempx-1,tempy-ps:tempy-1);
    patch2=image(tempx+1:tempx+ps,tempy-ps:tempy-1);
    patch3=image(tempx-ps:tempx-1,tempy+1:tempy+ps);
    patch4=image(tempx+1:tempx+ps,tempy+1:tempy+ps);
    patch=[patch1,patch2;patch3,patch4];%取角点周围16*16个像素作为patch
    v=simple_descriptor(patch);%展开patch，并标准正态化增加光照稳定性
    descriptors(i,:)=v;
end