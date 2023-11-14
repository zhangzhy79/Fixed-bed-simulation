% 计算初始的质量分数密度函数（均匀分布）
function adp0=initadp1(rmean,phir)
% rmean --- The mean value of r;
% phir --- The variance of r;粒径r的方差
global numx deltax
adp0=zeros(numx(1),numx(2)+1,numx(3)+1,numx(4)+1); 
numsum=0;
a=rmean-(3*phir)^0.5;b=rmean+(3*phir)^0.5;
for i=1:1:numx(1) % r方向的网格数
    r=rmean+deltax(1)*(i-(numx(1)+1)/2); 
    densityf=1/(2*(3*phir)^0.5)*(r-a>0)*(r-b<0); %得到初始的粒径分布，是高斯分布
    adp0(i,1,1,1)=densityf;
    numsum=numsum+densityf;
end
adp0=adp0/numsum;