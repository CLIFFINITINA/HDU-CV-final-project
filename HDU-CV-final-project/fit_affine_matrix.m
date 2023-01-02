function H=fit_affine_matrix(x,y,u,v)

L=length(x);
A=[];b=[];

% 根据最小二乘法公式构造三个矩阵
for i=1:L
    tempA=[x(i) y(i) 0 0 1 0;0 0 x(i) y(i) 0 1];
    A=[A;tempA];% 构造矩阵A
    tempb=[u(i);v(i)];
    b=[b;tempb];% 构造矩阵b
end

H=((A'*A)^-1)*A'*b;% 计算矩阵H

% 有时候由于噪声影响手动将它置为[0, 0, 1]
Tr=[H(1) H(2) H(5);H(3) H(4) H(6);0 0 1];
H=Tr;
end

