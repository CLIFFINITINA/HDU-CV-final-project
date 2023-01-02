function [matched_points,count]=match_descriptors(descriptors1,descriptors2)
k=0.7;
%初始化矩阵
[count1,~]=size(descriptors1);
[count2,~]=size(descriptors2);
matched_points=zeros(count1,2);
d=zeros(count1,count2);

%欧式距离矩阵
for i=1:count1
 for j=1:count2
        t1=descriptors1(i,:);
        t2=descriptors2(j,:);
        d(i,j)=sqrt(sum((t1-t2).^2));
  end
end
for i=1:count1
    [dmin,ind]=sort(d(i,:));
    dmin1=dmin(1);
    dmin2=dmin(2);
    
    q=dmin1/dmin2;
 if q<=k
        matched_points(i,1)=i;
        matched_points(i,2)=ind(1);
 end
end
matched_points(all(matched_points==0,2),:)=[];
count=size(matched_points,1);
end