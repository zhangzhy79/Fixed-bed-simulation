% 计算初始的质量分数密度函数
function adp0=initadp0(rmean,phir)
% rmean --- The mean value of r;
% phir --- The variance of r;粒径r的方差
global numx deltax
adp0=zeros(numx(1),numx(2)+1,numx(3)+1,numx(4)+1); 
a1=floor(numx(1)/2);a2=ceil(numx(1)/2);
if a1==a2
    adp0(a1,1,1,1)=0.5;adp0(a1+1,1,1,1)=0.5;
else
    adp0((a1+a2)/2,1,1,1)=1;
end
end