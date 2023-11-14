% �����ʼ�����������ܶȺ���
function adp0=initadp(rmean,phir)
% rmean --- The mean value of r;
% phir --- The variance of r;����r�ķ���
global numx deltax
adp0=zeros(numx(1),numx(2)+1,numx(3)+1,numx(4)+1); 
numsum=0;
for i=1:1:numx(1) % r�����������
    r=rmean+deltax(1)*(i-(numx(1)+1)/2); 
    densityf=1/((2*pi)^(1/2)*phir)*exp(-0.5*((r-rmean)/phir)^2); %�õ���ʼ�������ֲ����Ǹ�˹�ֲ�
    adp0(i,1,1,1)=densityf;
    numsum=numsum+densityf;
end
adp0=adp0/numsum;
% r=(0.5*deltax(1)):deltax(1):(deltax(1)*(numx(1)-0.5));
% y=normpdf(r,rmean,phir);
% y=y/sum(y);
% adp0(:,1)=y';