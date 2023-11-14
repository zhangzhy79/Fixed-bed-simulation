%% plot distribution
% （initadp0：单峰分布，initadp：正态分布，initadp1：均匀分布）
numx1=numx(1);

dist0=zeros(1,numx1);
dist1=zeros(1,numx1);
dist2=zeros(1,numx1);
ri=zeros(1,numx1);
% 单峰分布
a1=floor(numx1/2);a2=ceil(numx1/2);
if a1==a2
    dist0(a1)=0.5;dist0(a1+1)=0.5;
else
    dist0(a2)=1;
end
% 正态分布
numsum=0;
for i=1:1:numx1 % r方向的网格数
    r=rmean+deltax(1)*(i-(numx1+1)/2); 
    ri(i)=r;
    densityf=1/((2*pi)^(1/2)*phir)*exp(-0.5*((r-rmean)/phir)^2); %得到初始的粒径分布，是高斯分布
    dist1(i)=densityf;
    numsum=numsum+densityf;
end
dist1=dist1/numsum;
% 均匀分布
numsum=0;
a=rmean-(3*phir)^0.5;b=rmean+(3*phir)^0.5;
for i=1:1:numx(1) % r方向的网格数
    r=rmean+deltax(1)*(i-(numx1+1)/2); 
    densityf=1/(2*(3*phir)^0.5)*(r-a>0)*(r-b<0); %得到初始的粒径分布，是高斯分布
    dist2(i)=densityf;
    numsum=numsum+densityf;
end
dist2=dist2/numsum;

%plot
ri=ri*1e4;
figure(1)
bar(ri,dist0);
xlabel('\it\fontname{Times new Roman}{R}\rm\fontname{Times new Roman}\times10^{-4}/m'),ylabel('\rm\fontname{Times new Roman}Mass fraction')
axis([0,2*rmean*1e4,0,1])

figure(2)
bar(ri,dist1);
xlabel('\it\fontname{Times new Roman}{R}\rm\fontname{Times new Roman}\times10^{-4}/m'),ylabel('\rm\fontname{Times new Roman}Mass fraction')
axis([0,2*rmean*1e4,0,0.08])

figure(3)
bar(ri,dist2);
xlabel('\it\fontname{Times new Roman}{R}\rm\fontname{Times new Roman}\times10^{-4}/m'),ylabel('\rm\fontname{Times new Roman}Mass fraction')
axis([0,2*rmean*1e4,0,0.04])